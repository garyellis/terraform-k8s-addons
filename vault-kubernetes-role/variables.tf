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

variable "vault_auth_backend_path" {
  default = "kubernetes"
}

variable "vault_addr" {
  default = "https://vault-demo.ews.works"
}

variable "name" {
  description = "the role name"
}

variable "namespace" {
  description = "the role namespace binding"
}

variable "policy_rules" {
  description = "the vault role policy rules"
  type = list(object({
    description  = string
    path         = string
    capabilities = list(string)
  }))
  default = []
}
