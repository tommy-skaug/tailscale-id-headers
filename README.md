# Tailscale Identity Headers Demo

This repository is a companion to the Tailscale blog post “[Tapping into Tailscale’s identity headers with Serve](https://tailscale.dev/blog/id-headers-tailscale-serve-flask).” For more background, read that post, and then come back here to look under the hood. You can see the live demo at [https://id-headers-demo.pango-lin.ts.net](https://id-headers-demo.pango-lin.ts.net).

Note that these identity headers are tied to the underlying Tailscale connection, and so they work a little differently from a cookie-based authentication model. For example, the same headers will be sent when accessing the service within private browsing sessions, from different browsers, or even on the same user's other devices on the tailnet.


