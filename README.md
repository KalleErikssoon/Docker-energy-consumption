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
## Running Benchmarks Alpine
