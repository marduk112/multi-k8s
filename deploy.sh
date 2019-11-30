docker build -t marduk112/multi-client:latest -t marduk112/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marduk112/multi-server:latest -t marduk112/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marduk112/multi-worker:latest -t marduk112/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marduk112/multi-client:latest
docker push marduk112/multi-server:latest
docker push marduk112/multi-worker:latest


docker push marduk112/multi-client:$SHA
docker push marduk112/multi-server:$SHA
docker push marduk112/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=marduk112/multi-server:$SHA
kubectl set image deployments/client-deployment client=marduk112/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marduk112/multi-worker:$SHA