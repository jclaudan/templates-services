#!/bin/bash

# scriptvars
SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_FOLDER=$(dirname -- $SCRIPT_PATH)

# main
echo "wait for traefik to come up"
kubectl -n my-traefik rollout status deploy/traefik

echo "apply ClusterIssuer resources"
kubectl apply -f $SCRIPT_FOLDER/resources/IngressClass.yml
kubectl apply -f $SCRIPT_FOLDER/expose_ui/ingressroute.yml