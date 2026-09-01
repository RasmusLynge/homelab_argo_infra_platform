# GitOps project for Talos homelab


Using app of apps pattern

```
bootstrap/
├── projects/
│   ├── infra.yaml
│   └── apps.yaml
│
├── infra-crds-appset.yaml
├── infra-helm-appset.yaml
├── infra-manifests-appset.yaml
│
└── root-app.yaml

infra/                                 # generated apps only, no exceptions
├── argocd/
├── cert-manager/
└── external-secrets/

apps/
└── todo...
```