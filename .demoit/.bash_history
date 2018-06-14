go run main.go
docker build . -t hello:v1
docker run --rm -it hello:v1
vi pod.yaml
vi title/src/main/java/title/Title.java
vi ui/public/index.html
kubectl apply -f pod.yaml
kubectl logs -f hello
kctx gke_dga-demo_europe-west1-d_demo
kctx docker-for-desktop
./mvnw package
./mvnw compile jib:build -Dimage=gcr.io/dga-demo/hello-jib
kubectl get pods
kustomize build base
kustomize build overlays/prod
skaffold run --tail
docker pull gcr.io/dga-demo/hello-jib
skaffold build --cache-artifacts=false
