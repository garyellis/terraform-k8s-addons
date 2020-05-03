# vault-kubernetes-role
This module creates vault and kubernetes resources to setup a vault kubernetes auth method role. It will create the following resources:

* A kubernetes service account
* A vault policy
* A vault kubernetes auth method role that maps the kubernetes service account to the vault policy
* todo - an optional pki secret role
* todo - an optional kv secret engine

## Requirements
* A hashicorp vault server running at least version v1.2
* A kubernetes cluster
* Network connectivity beteeen the vault server and the kubernetes cluster
* Vault kubernetes auth method config is already setup

## Providers

| Name | Version |
|------|---------|
| kubernetes | n/a |
| vault | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_server\_url | the kube apiserver url | `string` | n/a | yes |
| ca\_crt | the apiserver cacert | `string` | n/a | yes |
| client\_cert | the apiserver client certificate | `string` | n/a | yes |
| client\_key | the apiserver client key | `string` | n/a | yes |
| name | the role name | `any` | n/a | yes |
| namespace | the role namespace binding | `any` | n/a | yes |
| policy\_rules | the vault role policy rules | <pre>list(object({<br>    description  = string<br>    path         = string<br>    capabilities = list(string)<br>  }))</pre> | `[]` | no |
| vault\_addr | n/a | `string` | `"https://vault-demo.ews.works"` | no |
| vault\_auth\_backend\_path | n/a | `string` | `"kubernetes"` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_name | n/a |
| role\_service\_account\_name | n/a |
