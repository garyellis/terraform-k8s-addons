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


###### cert-manager deployment
locals {
  cert_manager_ns = "cert-manager"
}


data "helm_repository" "jetstack" {
  name = "jetstack"
  url  = "https://charts.jetstack.io"
}

resource "kubernetes_service_account" "terraform" {
  metadata {
    name      = "terraform"
    namespace = "kube-system"
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "terraform" {

  metadata {
    name = kubernetes_service_account.terraform.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.terraform.metadata[0].name 
    namespace = "kube-system"
  }
}


resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = local.cert_manager_ns
    annotations = {}
    labels = {}
  }
}

resource "kubernetes_job" "install_cert_manager_crds" {
metadata {
    name      = "install-cert-manager-crds"
    namespace = "kube-system"
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name    = "hyperkube"
          image   = format("%s:%s", var.hyperkube_image, var.hyperkube_image_tag)
          command = ["kubectl", "apply", "-f", var.cert_manager_crds_manifest_url, "--validate=false"]
        }
        host_network                    = true
        automount_service_account_token = true
        service_account_name            = kubernetes_service_account.terraform.metadata[0].name
        restart_policy                  = "Never"
      }
    }
  }
}

resource "helm_release" "cert_manager" {
  repository = data.helm_repository.jetstack.metadata[0].name
  name       = "cert-manager"
  chart      = "cert-manager"
  version    = var.cert_manager_version
  namespace  = local.cert_manager_ns

  set {
    name = "image.repository"
    value = "quay.io/jetstack/cert-manager-controller"
  }

  set {
    name = "webhook.image.repository"
    value = "quay.io/jetstack/cert-manager-webhook"
  }

  set {
    name = "cainjector.image.repository"
    value = "quay.io/jetstack/cert-manager-cainjector"
  }

  depends_on = [
    kubernetes_service_account.terraform,
    kubernetes_cluster_role_binding.terraform,
    kubernetes_namespace.cert_manager,
    kubernetes_job.install_cert_manager_crds
  ]
}
