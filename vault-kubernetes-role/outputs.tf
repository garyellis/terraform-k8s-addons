output "role_name" {
  value = vault_kubernetes_auth_backend_role.vault_role.name
}

output "role_service_account_name" {
  value = kubernetes_service_account.vault_role.metadata.0.name
}
