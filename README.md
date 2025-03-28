# Docker-energy-consumption

Repository for storing different Dockerfiles which we will use to compare energy consumption in Docker containers.</br>
We will compare energy consumption in Docker containers using different base images (Alpine and Debian) running TPC-C and TPC-H benchmarks.</br>
We will then debloat the containers and run the same benchmarks to see if this has any effect on the energy consumption in the containers.</br>

## TPC-C Benchmark (Alpine)
Step 1. Build the image:
```
docker build -t postgres:alpine-tpcc -f alpine/tpcc/Dockerfile .

```
Step 2. Run the container:
```
source run_tpcc_alpine.tcl

```

Step 3. Run the Benchmark in hammerdb:
```
docker run -d --rm --name pg-alpine-tpcc -p 5433:5432 postgres:alpine-tpcc

```

## TPC-H Benchmark (Alpine)
Step 1. Build the image:
```
docker build -t postgres:alpine-tpch -f alpine/tpch/Dockerfile .

```
Step 2. Run the container:
```
docker run -d --rm --name pg-alpine-tpch -p 5433:5432 postgres:alpine-tpch

```

Step 3. Run the Benchmark in hammerdb:
```
source run_tpch_alpine.tcl

```

## TPC-C Benchmark (Debian)
Step 1. Build the image:
```
docker build -t postgres:debian-tpcc -f debian/tpcc/Dockerfile .

```
Step 2. Run the container:
```
docker run -d --rm --name pg-debian-tpcc -p 5433:5432 postgres:debian-tpcc

```

Step 3. Run the Benchmark in hammerdb:
Open the hammerdb cli.
Run the tcl script:
```
source run_tpcc_debian.tcl

```

## TPC-H Benchmark (Debian)
Step 1. Build the image:
```
docker build -t postgres:debian-tpch -f debian/tpch/Dockerfile .

```
Step 2. Run the container:
```
docker run -d --rm --name pg-debian-tpch -p 5433:5432 postgres:debian-tpch

```

Step 3. Run the Benchmark in hammerdb:
```
source run_tpch_debian.tcl

```

## How to run Kepler with Grafana and Prometheus to monitor energy consumption
### Prerequisites:
* Follow [this](https://sustainable-computing.io/installation/kepler/) installation guide (kubernetes, kepler, etc.)

Step 1. Deploy Kepler
```
cd ./kube-prometheus/kepler
make build-manifest OPTS="PROMETHEUS_DEPLOY"
kubectl apply -f _output/generated-manifest/deployment.yaml
```

Step 2. Forward Ports
```
kubectl port-forward --address localhost -n kepler service/kepler-exporter 9102:9102 &
kubectl port-forward --address localhost -n monitoring service/prometheus-k8s 9090:9090 &
kubectl port-forward --address localhost -n monitoring service/grafana 3000:3000 &
```

Step 3. Load kubernetes deployment into kind (make sure correct kind cluster)
```
kind load docker-image <IMAGE_NAME>
kubectl delete deployment <NAME>
kubectl apply <K8S DEPLOYMENT YAML> 
kubectl port-forward deployment/<NAME> 5433:5432
```

Step 4. Access Grafana at http://localhost:3000/

Step 5. Run Benchmarks with HammerDB (follow steps above in regards how to run HammerDB benchmarks)

Step 6. Query data in Grafana
* Energy consumption in 1 minute intervals
  ```
  increase(kepler_container_joules_total{pod_name="<POD_NAME"}[1m])
  ```
* Total energy consumption since container was started
  ```
  kepler_container_joules_total{pod_name="<POD_NAME>"}
  ```
* Export as CSV: Query Inspector -> Data -> Download as CSV
