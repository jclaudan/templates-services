#!/bin/bash
CHART_NAME="traefik"
REPO_NAME="traefik"
NAMESPACE="my-traefik"

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# apply helmchart with value file
RESULT=$(helm list -A --filter "$CHART_NAME$" -o json | jq '.[0].name')
[ "$RESULT" == "\"$CHART_NAME\"" ] && M='upgrade' || M='install'

echo "Running helm for $CHART_NAME in $M mode"
helm $M $CHART_NAME $REPO_NAME/$CHART_NAME \
 --values $SCRIPT_FOLDER/values.yml \
 -n $NAMESPACE --create-namespace

# on first install
[ "$M" == 'install' ] && {
    echo "wait for traefik to come up"
    kubectl -ntraefik-system rollout status deploy/traefik

    echo "apply ClusterIssuer resources"
    kubectl apply -f $SCRIPT_FOLDER/resources/IngressClass.yml
    kubectl apply -f $SCRIPT_FOLDER/expose_ui/ingressroute.yml
}