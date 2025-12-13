#!/bin/bash

# Project Cleanup Detection Script
# Identifies unnecessary files and folders for CI/CD projects

echo "🔍 Scanning for unnecessary files and folders..."
echo "================================================"

# Check for Python virtual environments
if [ -d ".venv" ] || [ -d "venv" ] || [ -d "env" ]; then
    echo "❌ Python Virtual Environment found:"
    ls -la | grep -E "(\.venv|venv|env)"
    echo "   → Can be removed (Docker handles dependencies)"
    echo ""
fi

# Check for Python cache files
if [ -d ".pytest_cache" ] || find . -name "__pycache__" -type d 2>/dev/null | grep -q .; then
    echo "❌ Python Cache files found:"
    find . -name ".pytest_cache" -o -name "__pycache__" -type d 2>/dev/null
    echo "   → Can be removed (auto-regenerated)"
    echo ""
fi

# Check for backup files
backup_files=$(find . -name "*.backup" -o -name "*.old" -o -name "*.bak" 2>/dev/null)
if [ ! -z "$backup_files" ]; then
    echo "❌ Backup files found:"
    echo "$backup_files"
    echo "   → Can be removed (old versions)"
    echo ""
fi

# Check for Helm charts (if using direct K8s + ArgoCD)
if [ -d "charts" ] || find . -name "Chart.yaml" 2>/dev/null | grep -q .; then
    echo "❌ Helm charts found:"
    find . -name "Chart.yaml" -o -name "charts" -type d 2>/dev/null
    echo "   → Can be removed if using direct K8s manifests + ArgoCD"
    echo ""
fi

# Check for temporary files
temp_files=$(find . -name "*.tmp" -o -name "*.temp" -o -name "*~" 2>/dev/null)
if [ ! -z "$temp_files" ]; then
    echo "❌ Temporary files found:"
    echo "$temp_files"
    echo "   → Can be removed (temporary files)"
    echo ""
fi

# Check for log files
log_files=$(find . -name "*.log" 2>/dev/null)
if [ ! -z "$log_files" ]; then
    echo "❌ Log files found:"
    echo "$log_files"
    echo "   → Can be removed (unless needed for debugging)"
    echo ""
fi

echo "✅ Essential files (keep these):"
echo "   - Dockerfile"
echo "   - index.html (or main application files)"
echo "   - k8s/ (Kubernetes manifests)"
echo "   - .github/workflows/ci.yml (active CI/CD)"
echo "   - argocd-app.yaml (GitOps config)"
echo "   - requirements.txt (dependencies)"
echo "   - README.md (documentation)"
echo "   - .git/ (version control)"
echo "   - .gitignore (git configuration)"
echo ""

echo "💡 Usage:"
echo "   1. Review the files listed above"
echo "   2. Move unnecessary files to backup: mkdir backup && mv [files] backup/"
echo "   3. Test your CI/CD pipeline"
echo "   4. Delete backup after confirming everything works"
