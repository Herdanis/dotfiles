function helm-dry
    helm install dry-run-helm-chart $argv[1] --debug --dry-run
end
