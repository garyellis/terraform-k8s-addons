# vault-kubernetes
Create vault kubernetes auth method for a kubernetes cluster. This terraform module creates the following resources:

* A vault kubernetes auth method backend
* A kubernetes vault-auth service account with clusterrole gives access tokenreview api
* A vault kubernetes auth method config
* installs the vault agent injector helm chart onto the kubernetes cluster

## Requirements
* Terraform v0.12+
* A Vault cluster running at least version 1.2.
* A Kubernetes cluster with token-lookups enabled. (on by default in v1.7+)
* Vault server network connectivity to kubernetes apiserver for authentication.k8s.io/v1/tokenreviews requests
* Kubernetes cluster network connectivity to the vault server

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | n/a |
| vault | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_server\_url | the kube apiserver url | `string` | n/a | yes |
| ca\_crt | the apiserver cacert | `string` | n/a | yes |
| client\_cert | the apiserver client certificate | `string` | n/a | yes |
| client\_key | the apiserver client key | `string` | n/a | yes |
| vault\_addr | n/a | `string` | `"https://vault-demo.ews.works"` | no |
| vault\_auth\_backend\_path | n/a | `string` | `"kubernetes"` | no |

## Outputs

No output.
