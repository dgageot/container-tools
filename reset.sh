#!/usr/bin/env bash

set -e

# rm -rf ~/cloudcode-projects/go-hello-world-1

if [[ "$(git describe --tags --always)" != "v1" ]]; then
    echo "The demo works best when the sources are tagged to v1"
    exit 1
fi

echo "Check that Istio is not running"
kubectl get ns istio-system -oname >/dev/null 2>&1 && echo "The demo works best without Istio running" && exit 1 || true

echo "Revoke additional accounts"
TO_REVOKE=$(gcloud auth list --format="value(account)" | grep -v 'dgageot@gmail.com' || true)
if [ ! -z "${TO_REVOKE}" ]; then
    gcloud auth revoke ${TO_REVOKE}
fi

echo "Reset GCP project"
if [ "$(gcloud config get-value project)" != "dga-demo" ]; then
  gcloud config set project dga-demo
fi

echo "Clean kubeconfig contexts"
CONTEXTS=$(kubectl config get-contexts -o name | grep -v 'docker-for-desktop' || true)
for context in $CONTEXTS; do
    kubectl config delete-context $context
done

echo "Get remote cluster"
gcloud container clusters get-credentials demo --zone europe-west1-d --project dga-demo

echo "Delete every remote k8s resource"
kctx gke_dga-demo_europe-west1-d_demo
TO_DELETE=$(kubectl get services,deployments.apps,pods -o name | grep -v 'service/kubernetes' || true)
if [ ! -z "${TO_DELETE}" ]; then
    kubectl delete ${TO_DELETE}
fi
kubectl delete secret kaniko-secret || true

echo "Delete every local k8s resource"
kctx docker-for-desktop
TO_DELETE=$(kubectl get services,deployments.apps,pods -o name | grep -v 'service/kubernetes' || true)
if [ ! -z "${TO_DELETE}" ]; then
    kubectl delete ${TO_DELETE}
fi

echo "Remove cloudcode gke configuration"
JSON=$(jq -M 'del(."cloudcode.gke")' "$HOME/Library/Application Support/Code/User/settings.json")
echo $JSON | jq "." > "$HOME/Library/Application Support/Code/User/settings.json"

kctx docker-for-desktop

cd repeat
go build
docker build . -t hello:v1

cd ../hello
rm -f skaffold.yaml
skaffold init -f - | skaffold build -f -

cd ../java
./mvnw package
docker build . -t hello-boot

cd ../jib
./mvnw compile jib:build -Dimage=gcr.io/dga-demo/hello-boot

cd ../gradle
./gradlew jib --image=gcr.io/dga-demo/hello-vertex

cd ../hexagons
kctx gke_dga-demo_europe-west1-d_demo
skaffold build
kctx docker-for-desktop
skaffold build

cd ../multi-stage
docker build .
docker pull gcr.io/distroless/base

cd ../multi-stage-java
docker build .
docker pull gcr.io/distroless/java:11

cd ../kustomize
kctx gke_dga-demo_europe-west1-d_demo
skaffold build -p prod
kctx docker-for-desktop
skaffold build
skaffold build -p prod
