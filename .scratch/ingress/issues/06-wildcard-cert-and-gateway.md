# 06 — Wildcard certificate + Gateway resource

**What to build:** A single wildcard certificate (per [[0007-wildcard-certificate]]) is issued and terminated by a Traefik-backed `Gateway`, ready for routes to attach to.

**Blocked by:** 01 (Traefik + Gateway API CRDs), 05 (Cloudflare DNS-01 ClusterIssuer ready)

**Status:** ready-for-agent

- [ ] A single wildcard `Certificate` (`*.<domain>`) requested against the `ClusterIssuer`, reaches status `Ready` (real DNS-01 challenge completes via Cloudflare)
- [ ] A `Gateway` resource created using Traefik's `GatewayClass`, terminating TLS with the wildcard certificate, exposed via `hostNetwork`
- [ ] The `Gateway` reaches `Programmed`/`Accepted` status
