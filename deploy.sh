docker build -t zozo6015/multi-client:latest -t zozo6015/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zozo6015/multi-server:latest -t zozo6015/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zozo6015/multi-worker:latest -t zozo6015/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push zozo6015/multi-client:latest
docker push zozo6015/multi-server:latest
docker push zozo6015/multi-worker:latest
docker push zozo6015/multi-client:$SHA
docker push zozo6015/multi-server:$SHA
docker push zozo6015/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zozo6015/multi-server:$SHA
kubectl set image deployments/client-deployment client=zozo6015/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zozo6015/multi-worker:$SHA