# 01 — Install Gateway API CRDs + deploy Traefik

**What to build:** Traefik becomes the cluster's ingress path, configured for Gateway API and exposed directly on the node (per [[0003-hostnetwork-over-metallb]], [[0004-gateway-api-over-traefik-ingressroute]]).

**Blocked by:** None — can start immediately

**Status:** done

- [x] Gateway API CRDs (standard channel: `GatewayClass`, `Gateway`, `HTTPRoute`, `ReferenceGrant`) installed in the cluster
- [x] Traefik deployed via an Argo CD `Application` using Traefik's **official Helm chart**, following this repo's existing app-of-apps pattern (an entry under `argocd/apps/` pointing at a chart-values directory, same shape as the `whoami` app)
- [x] Traefik configured with `hostNetwork: true` and the Kubernetes Gateway API provider enabled
- [ ] A `GatewayClass` for Traefik exists and reaches `Accepted`
- [ ] The Argo CD `Application` is `Synced` and `Healthy`

## Comments

Config implemented in commit 79e8615 (branch `main`) and validated locally (`helm template`, `kubectl kustomize` — both render cleanly; no live cluster access from this devcontainer). The last two checkboxes are cluster-runtime state and need confirming once Argo CD actually syncs this on the real Talos node.
