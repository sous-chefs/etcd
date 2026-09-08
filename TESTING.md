# Testing

Install Cinc Workstation and start Docker. Tests use privileged, disposable Dokken containers.

```sh
chef install Policyfile.rb
cookstyle
chef exec rspec --format documentation
KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen list
KITCHEN_LOCAL_YAML=kitchen.dokken.yml kitchen test '^default-ubuntu-2404$' --destroy=always
```

Kitchen performs two converges and rejects updates on the second. InSpec profiles live under `test/integration/<suite>/controls`. CI derives every suite/platform instance from Kitchen configuration. To run the full local matrix, omit the instance regex. Capture long runs in a named log and inspect convergence, idempotency and InSpec summaries.
