# tnext GitOps Configuration

Multi-app platform using ArgoCD with app-of-apps pattern and Helm charts.

## Repository Structure

```
argocd/
  root-app.yaml          # Bootstrap application
  tnext-project.yaml     # AppProject scope
  applications/
    tnext-appset.yaml    # Child ApplicationSet for tnext

apps/                    # Local app sources
  tnext/                 # Local Helm chart for tnext
clusters/
  dev/                   # Dev cluster configuration
```

## Applications

- **tnext**: Nginx web server deployed from a local Helm chart in `apps/tnext`
- **whoami**: containerized whoami service deployed from `apps/whoami`
- **Environment**: dev

## Getting Started

### 1. Install ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 2. Update cluster URLs

Edit `argocd/applications/tnext-appset.yaml` and replace:
- `https://kubernetes.default.svc` → your cluster API URL if different

### 3. Deploy root application

```bash
kubectl apply -f argocd/root-app.yaml
```

### 4. Monitor sync

```bash
kubectl get applications -n argocd
argocd app get argocd-root
```

The root app will automatically sync the child ApplicationSet and deploy both `tnext` and `whoami`.
