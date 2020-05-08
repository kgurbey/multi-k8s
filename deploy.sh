docker build -t kgurbey/multi-client:latest -t kgurbey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kgurbey/multi-server:latest -t kgurbey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kgurbey/multi-worker:latest -t kgurbey/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kgurbey/multi-client:latest
docker push kgurbey/multi-server:latest
docker push kgurbey/multi-worker:latest

docker push kgurbey/multi-client:$SHA
docker push kgurbey/multi-server:$SHA
docker push kgurbey/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kgurbey/multi-server:$SHA
kubectl set image deployments/client-deployment client=kgurbey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kgurbey/multi-server:$SHA