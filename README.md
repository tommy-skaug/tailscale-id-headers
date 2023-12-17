# Tailscale Identity Headers Web

This is a webpage that shows the visitor what state their Tailscale connection has and their headers that can be used for debugging.

Note that these identity headers are tied to the underlying Tailscale connection, and so they work a little differently from a cookie-based authentication model. For example, the same headers will be sent when accessing the service within private browsing sessions, from different browsers, or even on the same user's other devices on the tailnet.

This repository was build on the companion git repo to Tailscale blog post "[Tapping into Tailscale’s identity headers with Serve](https://tailscale.dev/blog/id-headers-tailscale-serve-flask)."

## Deploying to Kubernetes

The page can be deployed to Kubernetes and used with the Tailscale Operator.