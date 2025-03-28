### Debian TPC-H Dockerfile (debian-tpch/Dockerfile)
FROM debian:latest

ENV PGDATA=/var/lib/postgresql/data
ENV POSTGRES_PASSWORD=postgres

RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p "$PGDATA" && chown -R postgres:postgres /var/lib/postgresql

USER postgres

RUN /usr/lib/postgresql/*/bin/initdb -D "$PGDATA" && \
    /usr/lib/postgresql/*/bin/pg_ctl -D "$PGDATA" -o "-c listen_addresses='localhost'" -w start && \
    psql --username=postgres --command "ALTER USER postgres WITH PASSWORD 'postgres';" && \
    psql --username=postgres --command "CREATE USER tpch WITH PASSWORD 'tpch';" && \
    psql --username=postgres --command "CREATE DATABASE tpch OWNER tpch;" && \
    /usr/lib/postgresql/*/bin/pg_ctl -D "$PGDATA" -m fast -w stop

RUN echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf" && \
    echo "host all all all md5" >> "$PGDATA/pg_hba.conf"

EXPOSE 5432

CMD ["/usr/lib/postgresql/15/bin/postgres", "-D", "/var/lib/postgresql/data"]
