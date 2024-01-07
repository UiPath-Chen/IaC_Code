apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: vote-pr-applicationset
  namespace: argocd
spec:
  generators:
    - pullRequest:
        github:
          owner: gitkeystone
          repo: vote
          tokenRef:
            secretName: github-token
            key: token
        requeueAfterSeconds: 30
  template:
    metadata:
      name: "vote-pull-request-{{branch}}-{{number}}"
      annotations:
        prNumber: "{{number}}"
        prPreviewHost: "${prefix}.${domain}"
        githubOwner: gitkeystone
        githubRepo: vote
        notifications.argoproj.io/subscribe.on-sync-succeeded.github-webhook: "github-webhook"
    spec:
      project: default
      source:
        repoURL: "https://github.com/gitkeystone/vote-helm.git"
        targetRevision: HEAD
        path: "week-8"
        helm:
          valueFiles:
            - "values.yaml"
          parameters:
            - name: "RESULT.TAG"
              value: "{{head_sha}}"
            - name: "VOTE.TAG"
              value: "{{head_sha}}"
            - name: "WORKER.TAG"
              value: "{{head_sha}}"
            - name: HOST
              value: "${prefix}.${domain}"
      destination:
        server: "https://kubernetes.default.svc"
        namespace: "vote-pull-request-{{number}}"
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
