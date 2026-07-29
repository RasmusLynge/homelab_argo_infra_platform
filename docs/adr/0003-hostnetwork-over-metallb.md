# Expose Traefik via `hostNetwork` instead of MetalLB

Bare metal has no cloud load balancer (unlike the prior Hetzner setup), so something has to get Traefik a real IP. We chose `hostNetwork: true` on the Traefik pod over standing up MetalLB, since on a single node MetalLB's L2 mode provides no failover benefit anyway and `hostNetwork` avoids running an extra controller/CRDs for no gain. Revisit this (move to MetalLB) if a second node is ever added.
