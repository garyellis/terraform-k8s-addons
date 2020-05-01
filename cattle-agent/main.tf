provider "kubernetes" {
  host                   = var.api_server_url
  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
  load_config_file       = false
}

provider "rancher2" {
  api_url   = var.rancher2_api_url
  insecure  = true
  token_key = var.rancher2_token_key
}

resource "rancher2_cluster" "import_cluster" {
  name        = var.cluster_name
  description = format("imported rke cluster %s", var.cluster_name)
}

locals {
  insecure_import_cluster_cmd = rancher2_cluster.import_cluster.cluster_registration_token[0].insecure_command
}

resource "kubernetes_job" "import_cluster" {
  metadata {
    name      = "rancher-import-cluster"
    namespace = "kube-system"
  }
  spec {
    template {
      metadata {}
      spec {
        container {
          name  = "hyperkube"
          image = format("%s:%s", var.hyperkube_image, var.hyperkube_image_tag)
          command = [
            "/bin/sh",
            "-c"
          ]
          args = [
            local.insecure_import_cluster_cmd
          ]
        }
        host_network                    = true
        automount_service_account_token = true
        service_account_name            = var.service_account_name
        restart_policy                  = "Never"
      }
    }
  }
}
