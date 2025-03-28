### Alpine TPC-H Dockerfile (alpine-tpch/Dockerfile)
FROM alpine:latest

ENV PGDATA=/var/lib/postgresql/data
ENV POSTGRES_PASSWORD=postgres

RUN apk update && \
    apk add --no-cache postgresql postgresql-contrib su-exec

RUN mkdir -p "$PGDATA" /run/postgresql && \
    chown -R postgres:postgres /var/lib/postgresql /run/postgresql

USER postgres

RUN /usr/bin/initdb -D "$PGDATA" && \
    /usr/bin/pg_ctl -D "$PGDATA" -o "-c listen_addresses='localhost'" -w start && \
    psql --username=postgres --command "ALTER USER postgres WITH PASSWORD 'postgres';" && \
    psql --username=postgres --command "CREATE USER tpch WITH PASSWORD 'tpch';" && \
    psql --username=postgres --command "CREATE DATABASE tpch OWNER tpch;" && \
    /usr/bin/pg_ctl -D "$PGDATA" -m fast -w stop

RUN echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf" && \
    echo "host all all all md5" >> "$PGDATA/pg_hba.conf"

EXPOSE 5432

CMD ["/usr/bin/postgres", "-D", "/var/lib/postgresql/data"]
