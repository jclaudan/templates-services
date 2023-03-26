#!/bin/bash
CHART_NAME="cert-manager"
REPO_NAME="jetstack"
NAMESPACE="cert-manager"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)
set -e # break script on any error

# apply helmchart with value file
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/values.yml \
 -n $NAMESPACE --create-namespace

# first install
[ "$M" == 'install' ] && {
    echo "wait for $CHART_NAME to come up"
    kubectl -n $NAMESPACE rollout status deploy

    echo "apply secret resources"
    kubectl apply -f $SCRIPT_FOLDER/resources/secret.yml

    echo "apply ClusterIssuer resources"
    kubectl apply -f $SCRIPT_FOLDER/resources/issuer_selfsigned.yml
    kubectl apply -f $SCRIPT_FOLDER/resources/issuer_cloudflare.yml
}