# terraform-sa
Kubernetes terraform service account. This module creates the terraform service account used by terraform addon jobs.

## Requirements

* terraform v0.12

## Providers

| Name | Version |
|------|---------|
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_server\_url | the kube apiserver url | `string` | n/a | yes |
| ca\_crt | the apiserver cacert | `string` | n/a | yes |
| client\_cert | the apiserver client certificate | `string` | n/a | yes |
| client\_key | the apiserver client key | `string` | n/a | yes |
| labels | a map of labels applied to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | n/a |

