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

variable "service_account_name" {
  description = "run kubernetes jobs as this service account"
  type        = string
}

variable "hyperkube_image" {
  type    = string
  default = "rancher/hyperkube"
}

variable "hyperkube_image_tag" {
  type    = string
  default = "v1.17.4-rancher1"
}

variable "cert_manager_helm_repo" {
  default = "https://charts.jetstack.io"
}

variable "cert_manager_version" {
  default = "0.12.0"
}

variable "cert_manager_crds_manifest_url" {
  description = "cert-manager crds"
  default     = "https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml"
}

variable "cert_manager_controller_image_repository" {
  description = "the cert-manager-controller image repository"
  type        = string
  default     = "quay.io/jetstack/cert-manager-controller"
}

variable "cert_manager_webhook_image_repository" {
  description = "the cert-manager-webhook image repository"
  type        = string
  default     = "quay.io/jetstack/cert-manager-webhook"
}

variable "cert_manager_cainjector_image_repository" {
  description = "the cert-manager-webhook image repository"
  type        = string
  default     = "quay.io/jetstack/cert-manager-cainjector"
}

variable "labels" {
  description = "a map of labels applied to resources"
  type        = map(string)
  default     = {}
}

variable "annotations" {
  description = "a map of annotationss applied to cattle-system namespace"
  type        = map(string)
  default     = {}
}
