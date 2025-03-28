# Docker-energy-consumption

Repository for storing different Dockerfiles which we will use to compare energy consumption in Docker containers.</br>
We will compare energy consumption in Docker containers using different base images (Alpine and Debian) running TPC-C and TPC-H benchmarks.</br>
We will then debloat the containers and run the same benchmarks to see if this has any effect on the energy consumption in the containers.</br>

## Running TPC-C Benchmark for Debian Container
Step 1. Open Docker Desktop on your machine.</br> 
Step 2. Open a terminal in the root of this repository</br>
Step 3. Enter the following command in your terminal: </br>
```
cd debian
```
Step 4. Enter the following command in your terminal: </br>
```
docker build -t debian-postgres .
```
Step 5. Enter the following command in your terminal: </br>
```
docker run -d --name pg-tpcc -p 5433:5432 debian-postgres
```
Step 6. Copy the tpcc.tcl file into the same directory where you have installed HammerDB</br>
Step 7. Open the HammerDB CLI</br>
Step 8. Run the following command in the HammerDB CLI:</br>
```
source tpcc.tcl
```

---
## Running TPC-C benchmark for Alpine
Step 1. Open Docker Desktop on your machine.</br> 
Step 2. Open a terminal in the root of this repository</br> 
Step 3. Enter the following command in your terminal to build the Alpine-based image:</br> 
```
docker build -t postgres:16-alpine-custom -f alpine/Dockerfile .

```
Step 4. Start a PostgreSQL container from the custom Alpine image:</br>
#For windows CMD:</br>
```
docker run --rm --name pg-alpine -e POSTGRES_USER=hammerdb -e POSTGRES_PASSWORD=hammerpw -e POSTGRES_DB=tpcc -p 5433:5432 -d postgres:16-alpine-custom

```
#For For Git Bash / Linux / macOS:
```
docker run --rm --name pg-alpine \
  -e POSTGRES_USER=hammerdb \
  -e POSTGRES_PASSWORD=hammerpw \
  -e POSTGRES_DB=tpcc \
  -p 5433:5432 \
  -d postgres:16-alpine-custom
```
Step 5. Copy the run_tpcc.tcl file from hammerdb/ in this repo into the HammerDB installation directory</br>
(For example: C:\Program Files\HammerDB-4.12 on Windows)</br>
Step 6. Open a terminal and start the HammerDB CLI:</br>
```
cd "C:\Program Files\HammerDB-4.12"
hammerdbcli.bat
```
Step 7. From inside HammerDB CLI, run the following command:</br>
```
source run_tpcc.tcl

```
Step 8. Wait for the schema to be built and the benchmark to run. HammerDB will report the NOPM and TPM scores at the end.

---
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
