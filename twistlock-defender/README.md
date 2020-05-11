# twistlock-defender
Deploy twistlock defender daemonset to a kubernetes cluster. This implements the following:

* creates twistlock namespace
* Calls twistlock `/api/v1/defenders/daemonset.yaml` API to generate daemonset configuration
* Installs daemonset manifest to the cluster from twistlock console
* todo - add support for Hashicorp Vault kubernetes auth method role to handle twistlock api authentication

## Requirements

* terraform v0.12
* curl+kubectl docker image is needed for install kubernetes job


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
| hyperkube\_image | n/a | `string` | `"rancher/hyperkube"` | no |
| hyperkube\_image\_tag | n/a | `string` | `"v1.17.4-rancher1"` | no |
| labels | a map of labels applied to resources | `map(string)` | `{}` | no |
| namespace | The twistlock namespace | `string` | `"twistlock"` | no |
| service\_account\_name | run kubernetes jobs as this service account | `string` | n/a | yes |
| twistlock\_console\_addr | The twistlock console address <https://twistlock-console-dns:port> | `string` | n/a | yes |
| twistlock\_console\_bearer\_token | The bearer token for twistlock console authentication. Ensure the bearer token should have have a short ttl | `string` | n/a | yes |
| twistlock\_defender\_image | The twistlock defender image | `string` | `""` | no |

## Outputs

No output.
