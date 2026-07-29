# 01 — Install Gateway API CRDs + deploy Traefik

**What to build:** Traefik becomes the cluster's ingress path, configured for Gateway API and exposed directly on the node (per [[0003-hostnetwork-over-metallb]], [[0004-gateway-api-over-traefik-ingressroute]]).

**Blocked by:** None — can start immediately

**Status:** ready-for-agent

- [ ] Gateway API CRDs (standard channel: `GatewayClass`, `Gateway`, `HTTPRoute`, `ReferenceGrant`) installed in the cluster
- [ ] Traefik deployed via an Argo CD `Application` using Traefik's **official Helm chart**, following this repo's existing app-of-apps pattern (an entry under `argocd/apps/` pointing at a chart-values directory, same shape as the `whoami` app)
- [ ] Traefik configured with `hostNetwork: true` and the Kubernetes Gateway API provider enabled
- [ ] A `GatewayClass` for Traefik exists and reaches `Accepted`
- [ ] The Argo CD `Application` is `Synced` and `Healthy`
