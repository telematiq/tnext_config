# Revised
# tnext GitOps Configuration


Multi-app platform using ArgoCD with app-of-apps pattern.

## Repository Structure

```
argocd/
  root-app.yaml          # Bootstrap application
  tnext-appset.yaml      # ApplicationSet for env-based app generation
  projects/
    tnext-project.yaml   # AppProject scope
  applications/          # Standalone apps

apps/
  tnext/
    base/                # Base Kustomize manifests
    overlays/
      dev/               # Dev environment overlay
      prod/              # Prod environment overlay

clusters/
  dev/                   # Dev cluster configuration
  prod/                  # Prod cluster configuration
```

## Getting Started

### 1. Install ArgoCD

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### 2. Update cluster URLs

Edit `argocd/tnext-appset.yaml` and replace:
- `https://dev.k8s.local` → your dev cluster API URL
- `https://prod.k8s.local` → your prod cluster API URL

Or use `https://kubernetes.default.svc` for same-cluster deployments.

### 3. Deploy root application

```bash
kubectl apply -f argocd/root-app.yaml
```

### 4. Monitor sync

```bash
kubectl get applications -n argocd
argocd app get argocd-root
```

The root app will automatically sync all ApplicationSets and Projects.
