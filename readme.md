# GitOps project for Talos homelab
tbd

## Deployment structure

```
bootstrap/
├── apps/
│   ├── tbd...
├── infra/
│   ├── app-project.yaml
│   ├── crds-appset.yaml
│   ├── helm-appset.yaml
│   └── manifests-appset.yaml
└── root-app.yaml

infra/
├── argocd/
│   ├── crds
│   │   └── ...yaml
│   ├── helm
│   │   ├── config.yaml
│   │   └── values.yaml
│   └── manifests
│       └── ...yaml
├── cert-manager/
├── external-secrets/
└── ...

apps/
└── tbd...
```


The cluster is bootstrapped with argocd and the root app `bootstrap/root-app.yaml`. This root app deploys all resources residing in the `bootstrap/` dir. 

The configuration is split into two categories: 
- infra - for the base infrastructure.
- apps - for all the apps running on top. 