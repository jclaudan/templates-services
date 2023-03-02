#!/bin/bash
CHART_NAME="passbolt"
REPO_NAME="passbolt"
REPO_URL="https://download.passbolt.com/charts/passbolt"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
# FILE="$CHART_NAME-values.yml"
FILE="values.yml"

# crate values file
test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    # using helm
    helm repo add $REPO_NAME $REPO_URL
    helm repo update $REPO_NAME
    helm show values $REPO_NAME/$CHART_NAME > $SCRIPT_FOLDER/$FILE
}