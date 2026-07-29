# Configure routes via Gateway API instead of Traefik `IngressRoute`

Traefik supports three routing config surfaces: plain `Ingress` + annotations, its own `IngressRoute` CRD, and Gateway API (`Gateway`/`HTTPRoute`). We chose Gateway API since this is a fresh setup with no legacy config to preserve, and it's the standard the ecosystem (including the retiring `ingress-nginx`, see [[0001-traefik-over-ingress-nginx]]) is consolidating around, rather than Traefik-proprietary CRDs.

Confirmed Traefik's Gateway API mode supports attaching `ForwardAuth`/`RateLimit` middlewares to an `HTTPRoute` via the `ExtensionRef` filter, so this doesn't cost us Traefik's middleware ecosystem. One current limitation: cross-namespace `ExtensionRef` to a `Middleware` isn't supported yet (as of 2026) — a `Middleware` must live in the same namespace as the `HTTPRoute` referencing it.
