harbor:
  enabled: true
  persistence:                                      # PVC-持久化
    persistentVolumeClaim:
      registry:
        size: 20Gi
  externalURL: https://harbor.${prefix}.${domain}
  redis:                                            # Redis_Client(external-外部的、现有的、已存在的)
    type: external
    external:
      addr: "redis-master"
  database:                                         # DB_Client(external-外部的、现有的、已存在的)
    type: external
    external:
      host: "db-pgpool"
      username: "postgres"
      password: "postgres"
  expose:
    tls:                                            # TLS认证
      enabled: true
      certSource: secret
      secret:
        secretName: harbor-secret-tls
        notarySecretName: notary-secret-tls
    ingress:                                        # Ingress
      className: nginx
      annotations:
        kubernetes.io/tls-acme: "true"
        cert-manager.io/issuer: "harbor-issuer"
      hosts:
        core: harbor.${prefix}.${domain}
        notary: notary.${prefix}.${domain}
  # HA
  portal:
    replicas: 2
  core:
    replicas: 2
  jobservice:
    replicas: 2
  registry:
    replicas: 2
  chartmuseum:
    replicas: 2

redis:                                                  # Redis_Server
  enabled: true
  fullnameOverride: redis
  auth:
    enabled: false

postgresql-ha:                                          # DB_Server
  enabled: true
  fullnameOverride: db
  global:
    postgresql:
      username: postgres
      password: postgres
      database: registry
      repmgrUsername: postgres
      repmgrPassword: postgres
