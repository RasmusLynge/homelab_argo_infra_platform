# GitOps project for Talos homelab using ArgoCD

## Structure

```
bootstrap/                       # Helm chart: root app, AppProject, one Application per add-on
├── Chart.yaml
├── values.yaml                  # the add-on catalogue
└── templates/
    ├── root-app.yaml
    ├── app-project.yaml
    └── addons.yaml

addons/
└── <name>/
    ├── values.yaml              # Helm values for every cluster
    ├── values-<env>.yaml        # only what differs per environment (optional)
    └── manifests/               # extra resources, Kustomize (optional)
        ├── base/
        └── overlays/<env>/

clusters/
└── home-dev/
    ├── values.yaml              # cluster name, environment, enabled add-ons, version pins
    └── addons/<name>.yaml       # Helm values for this cluster only (optional)
```

There is one branch, `main`. Environments and clusters are folders and values files, never branches.

## Bootstrapping a cluster

1. Install Argo CD with Helm, using `addons/argocd/values.yaml` and `values-<env>.yaml`.
2. Apply the root app once:

   ```
   helm template root bootstrap -f clusters/home-dev/values.yaml | kubectl apply -f -
   ```

The root app renders `bootstrap/` with the cluster's values file, so from then on it manages itself,
the AppProject and every add-on.

## Add-ons

An add-on is a cluster-level component: Cilium, cert-manager, Kyverno and so on. Each is defined in three places:

1. **The catalogue** (`bootstrap/values.yaml`): what it is. Chart or git source, default version, namespace,
   pod security level and sync wave.
2. **Its folder** (`addons/<name>/`): how it is configured. Plain Helm values files plus optional manifests.
3. **A cluster file** (`clusters/<cluster>/values.yaml`): whether it runs there, and optionally a pinned version.

The bootstrap chart renders one Application per enabled add-on. It can have up to three sources:
- the Helm chart, with values from `addons/<name>/values.yaml`, then `values-<env>.yaml`, then
  `clusters/<cluster>/addons/<name>.yaml` (later files win, missing files are skipped)
- or a folder in another git repo (e.g. the Gateway API CRDs)
- `addons/<name>/manifests/overlays/<env>`, for resources the chart doesn't create

### Ordering

The root app syncs add-ons in sync waves and waits for each wave to be Healthy before the next:

| Wave | Add-ons |
|---|---|
| -10 | `gateway-api-crds`, `prometheus-operator-crds` |
| -5 | `cilium` |
| -3 | `external-secrets`, `kyverno` |
| -2 | `cert-manager`, `crossplane` |
| -1 | `gateway`, `tailscale` |
| 0 | `argocd`, `kube-prometheus-stack` |

An add-on's wave must be later than every add-on it depends on. E.g. cert-manager's ClusterIssuer uses an
ExternalSecret, so external-secrets comes first. An add-on that never gets Healthy stops later waves from updating.

Inside an add-on, the manifests get `argocd.argoproj.io/sync-wave: "1"` (`commonAnnotations` in `manifests/base`),
so they are applied after the chart is Healthy. Every Application retries failed syncs with backoff.

Waves rely on the Application health check in `addons/argocd/values.yaml`
(`resource.customizations.health.argoproj.io_Application`).

### CRDs shared by several add-ons
Installed first, by their own add-ons:
- `gateway-api-crds`: straight from the upstream repo (`config/crd` at a release tag).
  Check Cilium's supported Gateway API versions before bumping.
- `prometheus-operator-crds`: kube-prometheus-stack has `crds.enabled: false`.
  Keep it on the same operator version as kube-prometheus-stack.

### Adding an add-on
1. `addons/<name>/values.yaml` (and `manifests/` if needed)
2. An entry in the catalogue with the right wave
3. `<name>: { enabled: true }` in the cluster file

### Upgrading and promoting
Pin the new version in the cluster file first, e.g. `cert-manager: { enabled: true, chart: { version: v1.22.0 } }`.
When it is healthy, move the version to the catalogue default (or to the next cluster's file).

### Removing an add-on
Remove it from the cluster file. The Application is deleted but, without a finalizer, its resources stay;
delete them yourself. Be careful with add-ons that install CRDs: deleting a CRD deletes every resource of that kind.

## Making changes
Work on a short-lived branch and open a PR to `main`. A change in `addons/<name>/values.yaml` or the catalogue
reaches every cluster at once, so try risky changes in a cluster file or `values-<env>.yaml` first.

# tbd:
- Apps
- AppProjects per tier (bootstrap / platform / apps), lock down `default`
- CI: render every cluster, kubeconform, Kyverno policies, diff on PRs
- Renovate
