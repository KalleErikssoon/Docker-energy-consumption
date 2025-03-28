puts "TPC-C Benchmark on PostgreSQL (Alpine) in Docker Container"

dbset db pg
dbset bm TPC-C


diset connection pg_host localhost
diset connection pg_port 5433

diset tpcc pg_user hammerdb
diset tpcc pg_pass hammerpw
diset tpcc pg_dbase tpcc
diset tpcc pg_superuser hammerdb
diset tpcc pg_superuserpass hammerpw
diset tpcc pg_count_ware 1
diset tpcc pg_num_vu 1

buildschema

vudestroy

vucreate
vuset vu 1
vurun
waittocomplete

puts "TPC-C Benchmark complete"

