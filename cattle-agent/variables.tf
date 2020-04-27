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

variable "rancher2_api_url" {
  description = "The rancher server url"
  type        = string
}

variable "rancher2_token_key" {
  description = "the rancher server authentication token"
  type        = string
}

variable "cluster_name" {
  description = "the cluster name"
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

variable "labels" {
  description = "a map of labels applied to resources"
  type        = map(string)
  default     = {}
}
