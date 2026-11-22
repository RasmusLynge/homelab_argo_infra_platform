# GitOps project for Talos homelab using ArgoCD

## Deployment structure

Everything is plain Kustomize: each folder Argo renders has a `base/` and one `overlays/<env>/` per environment.

```
bootstrap/
├── base/
│   ├── kustomization.yaml
│   ├── root-app.yaml
│   └── infra/
│       ├── app-project.yaml
│       └── components-appset.yaml   # one parent app per infra component
└── overlays/
    ├── dev/kustomization.yaml       # branch dev, apps/overlays/dev
    └── prod/kustomization.yaml      # branch main, apps/overlays/prod

infra/
├── <component>/
│   ├── apps/                        # the component's Argo Applications
│   │   ├── base/
│   │   │   ├── kustomization.yaml
│   │   │   ├── helm.yaml            # <component>-helm: chart, version, valuesObject
│   │   │   ├── crds.yaml            # <component>-crds (optional)
│   │   │   └── manifests.yaml       # <component>-manifests (optional)
│   │   └── overlays/dev/
│   │       ├── kustomization.yaml   # points crds/manifests at their dev overlays
│   │       └── values.yaml          # Helm values that differ in dev (optional)
│   ├── crds/                        # optional: base/ + overlays/dev/
│   └── manifests/                   # optional: base/ + overlays/dev/
└── ...

apps/
└── tbd...
```

The cluster is bootstrapped with argocd and the root app: `kubectl apply -k bootstrap/overlays/<env>`.
The root app then manages everything in `bootstrap/overlays/<env>`, including itself.

The configuration is split into two categories:
- infra - for the base infrastructure.
- apps - for all the apps running on top. (tbd)

### Infra

```
root
└── infra-components             ApplicationSet
    ├── cert-manager             parent app: infra/cert-manager/apps/overlays/dev
    │   ├── cert-manager-helm        wave 0
    │   └── cert-manager-manifests   wave 1
    ├── gateway
    │   ├── gateway-crds             wave -1
    │   └── gateway-manifests        wave 1
    └── ...
```

#### Application project
`infra` is a pretty open project with close to no restrictions. It contains a whitelist of source repos.

#### Parent apps (`infra-components`)
The ApplicationSet creates one parent app for every component that has an `apps/overlays/<env>` folder.
A component runs in an environment when it has an overlay for it; adding a component is just adding the folder.

The parent renders the component's `apps/` folder, which holds its child Applications.
It also points every git-based child (label `git-source: "true"`) at the environment's branch, so components never mention the branch.

#### Child apps
- `helm.yaml`: the Helm chart, rendered by Argo's native Helm. The values live in `spec.source.helm.valuesObject`.
  Environment differences go in `apps/overlays/<env>/values.yaml`, a Kustomize patch that is merged into `valuesObject`.
  Lists are replaced, not merged, just like Helm's own values files.
- `crds.yaml` / `manifests.yaml`: plain Kustomize folders in this repo. The overlay points them at `crds/overlays/<env>` or `manifests/overlays/<env>`.

The parent syncs its children in sync waves (crds -1, helm 0, manifests 1), so e.g. a chart is healthy before the resources that need its CRDs or webhooks.
This relies on the Application health check in `infra/argocd/apps/base/helm.yaml` (`resource.customizations.health.argoproj.io_Application`).
Sync waves are not respected between components, because the parents are created by an ApplicationSet.

# tbd:
- Apps
- AppProjects per tier (bootstrap / infra / apps), lock down `default`
