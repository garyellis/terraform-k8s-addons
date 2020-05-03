provider "kubernetes" {
  host                   = var.api_server_url
  client_certificate     = var.client_cert
  client_key             = var.client_key
  cluster_ca_certificate = var.ca_crt
  load_config_file       = false
}

data "vault_policy_document" "role_policy" {
  rule {
    path         = format("secret/%s", var.name)
    capabilities = ["read", "list"]
  }

  dynamic "rule" {
    for_each = var.policy_rules
    content {
      description  = lookup(rule.value, "description", null)
      path         = lookup(rule.value, "path")
      capabilities = lookup(rule.value, "capabilities", ["read"])
    }
  }
}

resource "vault_policy" "role_policy" {
  name   = var.name
  policy = data.vault_policy_document.role_policy.hcl
}

resource "vault_kubernetes_auth_backend_role" "vault_role" {
  backend                          = var.vault_auth_backend_path
  role_name                        = var.name
  bound_service_account_names      = list(kubernetes_service_account.vault_role.metadata.0.name)
  bound_service_account_namespaces = list(var.namespace)
  token_ttl                        = 86400
  token_policies                   = ["default", vault_policy.role_policy.name]
}

# can be a list of maps [{ namespace = "", name = ""}]
resource "kubernetes_service_account" "vault_role" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
}
