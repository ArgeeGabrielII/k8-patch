#!/bin/bash
jq -r 'to_entries[] | "\(.key)\t\(.value)"' stag.json |
while read key value
do
p=$(cat <<-END
    {
        "id": "$key",
        "type": "command",
        "command": "shellCommand.execute",
        "args": {
            "command": "kubectl get secret hasura-secret -o jsonpath='{.data.$key}' | base64 -d",
            "useFirstResult": true
        }
    },
END
)
echo $p
done

echo $(kubectl get configmap hasura-config -o jsonpath='{.data}') > /tmp/env.json
