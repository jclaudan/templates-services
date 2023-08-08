#!/bin/bash
kubectl exec -n my-paperless-ngx -it deployment.apps/paperless-ngx-app -- python3 manage.py createsuperuser