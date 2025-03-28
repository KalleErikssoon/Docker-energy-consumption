puts "TPC-H Benchmark on PostgreSQL (Alpine) in Docker Container"

dbset db pg
dbset bm TPC-H

diset connection pg_host localhost
diset connection pg_port 5433
diset connection pg_user postgres
diset connection pg_pass postgres

diset tpch pg_dbase tpch
diset tpch pg_tpch_superuser postgres
diset tpch pg_tpch_superuserpass postgres
diset tpch pg_tpch_user tpch
diset tpch pg_tpch_pass tpch
diset tpch pg_num_tpch_threads 1

vudestroy
buildschema
vucreate
vuset vu 1
vurun
waittocomplete

puts "TPC-H Benchmark complete"
