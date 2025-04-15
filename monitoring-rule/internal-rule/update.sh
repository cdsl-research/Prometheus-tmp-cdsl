find . -name "*.yaml" -o -name "*.yml" | xargs -I{} kubectl delete -f {}
find . -name "*.yaml" -o -name "*.yml" | xargs -I{} kubectl apply -f {}
