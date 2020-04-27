# cert-manager
Deploy the cert-manager helm chart to a kubernetes cluster.

## Requirements

Terraform v0.12

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_server\_url | the kube apiserver url | `string` | n/a | yes |
| ca\_crt | the apiserver cacert | `string` | n/a | yes |
| cert\_manager\_cainjector\_repository | the cert-manager-webhook image repository | `string` | `"quay.io/jetstack/cert-manager-cainjector"` | no |
| cert\_manager\_controller\_image\_repository | the cert-manager-controller image repository | `string` | `"quay.io/jetstack/cert-manager-controller"` | no |
| cert\_manager\_crds\_manifest\_url | cert-manager crds | `string` | `"https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml"` | no |
| cert\_manager\_helm\_repo | n/a | `string` | `"https://charts.jetstack.io"` | no |
| cert\_manager\_version | n/a | `string` | `"0.12.0"` | no |
| cert\_manager\_webhook\_image\_repository | the cert-manager-webhook image repository | `string` | `"quay.io/jetstack/cert-manager-webhook"` | no |
| client\_cert | the apiserver client certificate | `string` | n/a | yes |
| client\_key | the apiserver client key | `string` | n/a | yes |
| hyperkube\_image | n/a | `string` | `"rancher/hyperkube"` | no |
| hyperkube\_image\_tag | n/a | `string` | `"v1.17.4-rancher1"` | no |
| labels | a map of labels applied to resources | `map(string)` | `{}` | no |
| service\_account\_name | run kubernetes jobs as this service account | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| chart\_metadata | n/a |

