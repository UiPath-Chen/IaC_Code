# Create Crossplane platform
```bash
terraform init
terraform apply -auto-approve
```

# Kubernetes Config
```bash
cp ./config.yaml ~/.kube/config
kubectl get cs
```