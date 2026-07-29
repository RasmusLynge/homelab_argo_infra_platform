# Stay on Flannel for now; defer a Cilium CNI migration

We're considering Cilium as a future CNI swap (for `NetworkPolicy`/`CiliumNetworkPolicy` enforcement — Flannel enforces no network policy at all). We decided not to do that migration now, since it requires a machine config change and reboot on Talos and is meaningfully more disruptive once real workloads are running. Today this cluster only runs a `whoami` test app, so there's nothing costly to redo later — we're deliberately taking on Flannel now and will revisit Cilium once the network-policy need becomes concrete.

_Ingress work (see [[0001-traefik-over-ingress-nginx]]) proceeds on Flannel; Traefik is CNI-agnostic so this doesn't block it._
