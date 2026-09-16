# GitOps project for Talos homelab using ArgoCD

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
- apps - for all the apps running on top. (tbd)


### Infra
The infrastructure is set up with one application project and three applicationSets. 

#### Application project
This is a pretty open application set with close to no restrictions. Contains a whitelist of source repos.

#### ApplicationSets
These three application sets loops trough every folder within `infra/` and creates argo applications for each subfolder matching:

- crds
- helm
- manifests

##### crds
If a subfolder within `infra/` contains a crd folder, Argo creates an application named `<subfolder>-crds` with the lowest sync wave in this repo (-10).  
All crd apps will be the first argocd creates.

##### helm
If a subfolder within `infra/` contains a helm folder, Argo creates  an application named `<subfolder>`.
The helm folder must include two files:

1: config.yaml
    includes the necessary configs for the helm repo. Name, chart, repo, version, sync wave etc.
2: values.yaml
    contains the helm chart values

##### manifests
tbd

