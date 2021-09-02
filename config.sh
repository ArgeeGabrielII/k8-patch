# !/bin/bash
# reference commands used to prepare this script
# kubectl create configmap hasura-config --from-literal=key=value
# kubectl get configmap hasura-config -o yaml
# kubectl edit configmap hasura-config
# kubectl delete configmap hasura-config

# prepare payload
p=$(cat <<-END
    [
        {
            "op":"replace",
            "path":"/data/$1",
            "value":"$2"
        }
    ]
END
)

# commit patch
kubectl patch configmap hasura-config --type='json' -p="$p"

# verify patch ignore '%' in stdout
kubectl get configmap hasura-config --template="$1: {{.data.$1}}"
