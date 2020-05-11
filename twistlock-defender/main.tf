provider "kubernetes" {
  host                   = var.api_server_url
  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
  load_config_file       = false
}

locals {
  twistlock_console_addr = regex("^(?:(?P<protocol>[^:/?#]+):)?(?://(?P<hostname>[^/?#:]*)?[:]*(?P<port>[0-9]+)*(?P<path>[/]*.*)?)", var.twistock_console_addr)
  image_param            = var.twistlock_defender_image == "" ? "" : format("image=%", var.twistlock_defender_image)
  get_ds_yaml = format("%s/api/v1/defenders/daemonset.yaml?consoleadr=%s&namespace=%s&orchestrator=kubernetes&priviledged=true&%s",
    var.twistlock_console_addr,
    local.twistlock_console_addr["hostname"],
    var.namespace,
    local.image_param
  )

  install_cmd = <<EOT
curl -k -s -H "Content-Type: application/json" -H "authorization: Bearer ${var.twistlock_console_bearer_token}" "${local.get_ds_yaml}" | kubectl apply -f -validate=false
EOT

}

resource "kubernetes_namespace" "twistlock" {
  metadata {
    name        = var.namespace
    annotations = var.annotations
    labels      = var.labels
  }
}

resource "kubernetes_job" "install_twistlock_defender" {
  metadata {
    name      = "install-twistlock-defender"
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
            local.install_cmd
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
