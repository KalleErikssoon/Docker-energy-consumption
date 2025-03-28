puts "TPC-H Benchmark on PostgreSQL (Debian) in Docker Container"

dbset db pg
dbset bm TPC-H

diset connection pg_host localhost
diset connection pg_port 5433

# Overwrite TPC-H-specific values
diset tpch pg_tpch_user postgres
diset tpch pg_tpch_pass hammerpw
diset tpch pg_tpch_dbase tpch
diset tpch pg_tpch_superuser postgres
diset tpch pg_tpch_superuserpass hammerpw
diset tpch pg_scale_fact 1
diset tpch pg_num_tpch_threads 1

buildschema

vudestroy
vucreate
vuset vu 1
vurun
waittocomplete

puts "TPC-H Benchmark complete"
