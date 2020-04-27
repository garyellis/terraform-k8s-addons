provider "kubernetes" {
  host                   = var.api_server_url
  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
  load_config_file       = false
}

resource "kubernetes_service_account" "terraform" {
  metadata {
    name      = "terraform"
    namespace = "kube-system"
    labels    = var.labels
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role_binding" "terraform" {
  metadata {
    name   = kubernetes_service_account.terraform.metadata[0].name
    labels = var.labels
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
