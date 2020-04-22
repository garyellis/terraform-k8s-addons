variable "api_server_url" {
  description = "the kube apiserver url"
  type        = string
}

variable "client_cert" {
  description = "the apiserver client certificate"
  type        = string
}

variable "client_key" {
  description = "the apiserver client key"
  type        = string
}

variable "ca_crt" {
  description = "the apiserver cacert"
  type        = string
}

variable "hyperkube_image" {
  type = string
  default = "rancher/hyperkube"
}

variable "hyperkube_image_tag" {
  type = string
  default = "v1.17.4-rancher1"
}

variable "cert_manager_version" {
  default = "0.12.0"
}

variable "cert_manager_crds_manifest_url" {
  description = "cert-manager crds"
  default = "https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml"
}


