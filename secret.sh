#!/bin/bash
# reference commands used to prepare this script
# kubectl create secret generic hasura-secret --from-literal=key=value
# kubectl get secret hasura-secret -o yaml
# kubectl edit secret hasura-secret
# kubectl delete secret hasura-secret

# prepare payload
value=$(echo -n $2 | base64 -w0)
p=$(cat <<-END
    [
        {
            "op":"replace",
            "path":"/data/$1",
            "value":"$value"
        }
    ]
END
)

echo $p;

# commit patch
kubectl patch secret hasura-secret --type='json' -p="$p"

# verify patch ignore '%' in stdout
kubectl get secret hasura-secret --template="$1: {{.data.$1|base64decode}}"
