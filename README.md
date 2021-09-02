# Key Value Pair Management
Make script executable
```
chmod +x ./*.sh
```
## ConfigMap
Add or update a configuration
```
./hasura-config.sh KEY_HERE VALUE_HERE

# example
./hasura-config.sh HASURA_ENDPOINT 'https://example.com/v1/graphql'

# note: url or json values needs to be qouted
```
Update helm `deployment.yaml`
```
# example 
containers:
    env:
      - name: HASURA_ENDPOINT
        valueFrom:
          configMapKeyRef:
            name: hasura-config
            key: HASURA_ENDPOINT
```
## Secrets
Add or update a secret
```
./hasura-secret.sh KEY_HERE VALUE_HERE

# example
./hasura-secret.sh HASURA_SECRET supersecretstring

# example for json
./hasura-secret.sh SECRET_VALUEE_NAME '{"mini":"json_here"}'

# note: url or json values needs to be qouted
```
Update helm `deployment.yaml`
```
# example 
containers:
    env:
      - name: HASURA_SECRET
        valueFrom:
          secretKeyRef:
              name: hasura-secret
              key: HASURA_SECRET
```
## References
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/
- https://opensource.com/article/19/6/introduction-kubernetes-secrets-and-configmaps
- Inspect `./hasura-config.sh` and `./hasura-config.sh` for more information


## Minify JSON Data
```
  # Ubnutu (Pre Requisite)
  sudo apt-get install jq
  jq -c . < ./service_account.json
```