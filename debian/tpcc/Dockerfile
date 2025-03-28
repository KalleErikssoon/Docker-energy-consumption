### Debian TPC-C Dockerfile (debian-tpcc/Dockerfile)
FROM debian:latest

ENV PGDATA=/var/lib/postgresql/data
ENV POSTGRES_USER=hammerdb
ENV POSTGRES_PASSWORD=hammerpw
ENV POSTGRES_DB=tpcc

RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p "$PGDATA" && chown -R postgres:postgres /var/lib/postgresql

USER postgres

RUN /usr/lib/postgresql/*/bin/initdb -D "$PGDATA" && \
    /usr/lib/postgresql/*/bin/pg_ctl -D "$PGDATA" -o "-c listen_addresses='localhost'" -w start && \
    psql --username=postgres --command "CREATE USER hammerdb WITH PASSWORD 'hammerpw';" && \
    psql --username=postgres --command "CREATE DATABASE tpcc OWNER hammerdb;" && \
    /usr/lib/postgresql/*/bin/pg_ctl -D "$PGDATA" -m fast -w stop

RUN echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf" && \
    echo "host all all all md5" >> "$PGDATA/pg_hba.conf"

EXPOSE 5432

CMD ["/usr/lib/postgresql/15/bin/postgres", "-D", "/var/lib/postgresql/data"]
