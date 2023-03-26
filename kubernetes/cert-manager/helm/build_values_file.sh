#!/bin/bash
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
FILE=cert-manager-values.yml

test -f "$SCRIPT_FOLDER/$FILE" && echo "$FILE already exists" || {
    # using helm
    helm repo add jetstack https://charts.jetstack.io
    helm repo update
    helm show values jetstack/cert-manager > $SCRIPT_FOLDER/$FILE
}
