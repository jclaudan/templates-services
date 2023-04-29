#!/bin/bash
CHART_NAME="traefik"
REPO_NAME="traefik"
REPO_URL="https://traefik.github.io/charts"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE="values.yml"

# crate values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    # using helm
    helm repo add $REPO_NAME $REPO_URL
    helm repo update $REPO_NAME
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}