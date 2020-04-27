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
  url  = var.cert_manager_helm_repo
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name        = local.cert_manager_ns
    annotations = var.annotations
    labels      = var.labels
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
        service_account_name            = var.service_account_name
        restart_policy                  = "Never"
      }
    }
  }
}

resource "helm_release" "cert_manager" {
  repository   = data.helm_repository.jetstack.metadata[0].name
  name         = "cert-manager"
  chart        = "cert-manager"
  version      = var.cert_manager_version
  namespace    = local.cert_manager_ns
  reuse_values = true

  set {
    name  = "image.repository"
    value = var.cert_manager_controller_image_repository
  }

  set {
    name  = "webhook.image.repository"
    value = var.cert_manager_webhook_image_repository
  }

  set {
    name  = "cainjector.image.repository"
    value = var.cert_manager_cainjector_image_repository
  }

  depends_on = [
    kubernetes_namespace.cert_manager,
    kubernetes_job.install_cert_manager_crds
  ]
}
