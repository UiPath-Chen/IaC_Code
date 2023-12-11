apiVersion: v1
kind: Secret
metadata:
  name: sonar-url
  labels:
    "jenkins.io/credentials-type": "secretText"
  annotations:
    "jenkins.io/credentials-description" : "sonar url"
type: Opaque
stringData:
  text: sonar.${prefix}.${domain}
