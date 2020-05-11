# terraform-k8s-addons
Deploy common kubernetes addons with terraform. This repo includes the following deployments:

* cert-manager - deploys the certmanager application
* cattle-agent - registers a cluster to rancher
* twistlock-defender - deploys twistlock defender daemonset
* vault-kubernetes - creates vault kubernetes auth method for a cluster
* vault-kubernetes-role - creates a vault kubernetes role for an application
