provider "kubernetes" {
  host                   = var.api_server_url
  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = var.api_server_url
    client_certificate     = var.client_cert
    client_key             = var.client_key
    cluster_ca_certificate = var.ca_crt
    load_config_file       = false
  }
}

resource "vault_auth_backend" "kubernetes" {
  path = var.vault_auth_backend_path
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes_cluster" {
  backend            = vault_auth_backend.kubernetes.path
  kubernetes_host    = format("https://%s", var.api_server_url)
  kubernetes_ca_cert = var.ca_crt
  token_reviewer_jwt = data.kubernetes_secret.token_reviewer_jwt.data.token
}

## considering creating the vault auth service account in the vault namespace
resource "kubernetes_service_account" "vault_auth" {
  metadata {
    name = "vault-auth"
    namespace = "default"
  }
}

resource "kubernetes_secret" "vault_auth_token" {
  metadata {
    name = "vault-auth"
    namespace = "default"
    annotations = {
      "kubernetes.io/service-account.name" = "vault-auth"
    }
  }

  type = "kubernetes.io/service-account-token"
}

data "kubernetes_secret" "token_reviewer_jwt" {
  depends_on = [
    kubernetes_service_account.vault_auth,
    kubernetes_secret.vault_auth_token
  ]
  metadata {
    name = kubernetes_secret.vault_auth_token.metadata.0.name
  }
}

resource "kubernetes_cluster_role_binding" "vault_auth" {
  metadata {
    name = "role-tokenreview-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
  subject {
    kind = "ServiceAccount"
    name = "vault-auth"
    namespace = "default"
  }
}

#### setup the vault agent injector service
resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
}

resource "helm_release" "vault" {
  depends_on = [
    kubernetes_cluster_role_binding.vault_auth,
    vault_auth_backend.kubernetes
  ]

  name      = "vault"
  # chart will need to be parameterized to support private or air gap installations
  # helm repo support will be added to simiplify private or air gap installations
  chart     = "https://github.com/hashicorp/vault-helm/archive/v0.5.0.tar.gz"
  namespace = kubernetes_namespace.vault.metadata.0.name

  values = [
    templatefile("${path.module}/vault-values.tmpl", {
      vault_addr = var.vault_addr
    })
  ]
}
