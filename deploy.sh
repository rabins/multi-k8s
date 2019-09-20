docker build -t rabinds/multi-client:latest -t rabinds/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rabinds/multi-server:latest -t rabinds/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rabinds/multi-worker:latest -t rabinds/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rabinds/multi-client:latest
docker push rabinds/multi-server:latest
docker push rabinds/multi-worker:latest

docker push rabinds/multi-client:$SHA
docker push rabinds/multi-server:$SHA
docker push rabinds/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rabinds/multi-server:$SHA
kubectl set image deployments/client-deployment client=rabinds/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rabinds/multi-worker:$SHA