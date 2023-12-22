#!/bin/bash
CHART_NAME="longhorn"
REPO_NAME="longhorn"
REPO_URL="https://charts.longhorn.io"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yml"

# add helm chart
helm repo add $REPO_NAME $REPO_URL
helm repo update $REPO_NAME

# crate values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}