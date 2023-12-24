apiVersion: v1
kind: Secret
metadata:
  name: github-pat-secret-text
  labels:
    "jenkins.io/credentials-type": "secretText"
  annotations:
    "jenkins.io/credentials-description" : "github pat"
type: Opaque
stringData:
  text: "${github_personal_token}"

  github_pat_11AJFOQ5A0lWJq5Qamp5zF_wN2r97AGt4VVT979L6Rq
  oBojFFuij0hTvUm8TnKkGkSWZ2ASKKUdj2FG6R5