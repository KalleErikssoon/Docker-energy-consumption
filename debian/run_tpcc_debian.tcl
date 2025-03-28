puts "TPC-C Benchmark on PostgreSQL in Docker Container"

dbset db pg

diset connection pg_host localhost
diset connection pg_port 5433

diset tpcc pg_user hammerdb
diset tpcc pg_pass hammerpw
diset tpcc pg_dbase tpcc
diset tpcc pg_superuser hammerdb
diset tpcc pg_superuserpass hammerpw
diset tpcc pg_count_ware 5
diset tpcc pg_num_vu 5

buildschema

vucreate
vuset vu 1
vurun
waittocomplete

puts "TPC-C Benchmark complete"
exit
