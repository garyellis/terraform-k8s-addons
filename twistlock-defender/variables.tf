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

variable "namespace" {
  description = "The twistlock namespace"
  type        = string
  default     = "twistlock"
}

variable "twistlock_console_addr" {
  description = "The twistlock console address <https://twistlock-console-dns:port>"
  type        = string
}

variable "twistlock_console_bearer_token" {
  description = "The bearer token for twistlock console authentication. Ensure the bearer token should have have a short ttl"
  type        = string
}

variable "twistlock_defender_image" {
  description = "The twistlock defender image"
  type        = string
  default     = ""
}

variable "hyperkube_image" {
  type    = string
  default = "rancher/hyperkube"
}

variable "hyperkube_image_tag" {
  type    = string
  default = "v1.17.4-rancher1"
}

variable "labels" {
  description = "a map of labels applied to resources"
  type        = map(string)
  default     = {}
}
