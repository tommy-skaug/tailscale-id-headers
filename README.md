# Tailscale Identity Headers Web

This is a webpage that shows the visitor what state their Tailscale connection has and their headers that can be used for debugging.

The identity headers are tied to the underlying Tailscale connection, and so they work a little differently from a cookie-based authentication model. For example, the same headers will be sent when accessing the service within private browsing sessions, from different browsers, or even on the same user's other devices on the tailnet.

This repository is modified from the companion git repo to Tailscale blog post "[Tapping into Tailscale’s identity headers with Serve](https://tailscale.dev/blog/id-headers-tailscale-serve-flask)".

## Deploying to Kubernetes

The container can be deployed as an [app-template](https://github.com/bjw-s/helm-charts) to Kubernetes and be used with the Tailscale Operator like this:

```
---
apiVersion: helm.toolkit.fluxcd.io/v2beta2
kind: HelmRelease
metadata:
  name: &app tailscale-id-headers
spec:
  interval: 30m
  chart:
    spec:
      chart: app-template
      version: 2.4.0
      sourceRef:
        kind: HelmRepository
        name: bjw-s-charts
        namespace: flux-system
  maxHistory: 2
  install:
    remediation:
      retries: 3
  upgrade:
    cleanupOnFail: true
    remediation:
      retries: 3
  uninstall:
    keepHistory: false
  values:
    controllers:
      main:
        replicas: 2
        strategy: RollingUpdate
        annotations:
          reloader.stakater.com/auto: "true"
        containers:
          main:
            image:
              repository: ghcr.io/tommy-skaug/tailscale-id-headers
              tag: v1.1
            probes:
              readiness:
                custom: true
                spec:
                  httpGet:
                    path: /
                    port: 5000
              liveness:
                custom: true
                spec:
                  httpGet:
                    path: /
                    port: 5000
              startup:
                enabled: false
            resources:
              limits:
                memory: 85M
            securityContext:
              allowPrivilegeEscalation: true
              readOnlyRootFilesystem: false
              capabilities:
                drop:
                  - ALL
        pod:
          securityContext:
            runAsUser: 568
            runAsGroup: 568
            runAsNonRoot: true
          topologySpreadConstraints:
            - maxSkew: 1
              topologyKey: kubernetes.io/hostname
              whenUnsatisfiable: DoNotSchedule
              labelSelector:
                matchLabels:
                  app.kubernetes.io/name: *app
    service:
      main:
        ports:
          http:
            port: 5000
    serviceMonitor:
      main:
        enabled: true
    serviceAccount:
      create: true
      name: *app
```
