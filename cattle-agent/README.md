# cattle-agent
Import an existing kubernetes cluster to rancher2

## Requirements

* terraform v0.12
* curl+kubectl docker image is needed for import cluster kubernetes job


## Providers

| Name | Version |
|------|---------|
| kubernetes | n/a |
| rancher2 | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_server\_url | the kube apiserver url | `string` | n/a | yes |
| ca\_crt | the apiserver cacert | `string` | n/a | yes |
| client\_cert | the apiserver client certificate | `string` | n/a | yes |
| client\_key | the apiserver client key | `string` | n/a | yes |
| cluster\_name | the cluster name | `string` | n/a | yes |
| hyperkube\_image | n/a | `string` | `"rancher/hyperkube"` | no |
| hyperkube\_image\_tag | n/a | `string` | `"v1.17.4-rancher1"` | no |
| rancher2\_api\_url | The rancher server url | `string` | n/a | yes |
| rancher2\_token\_key | the rancher server authentication token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| api\_url | n/a |
| import\_cluster | n/a |
