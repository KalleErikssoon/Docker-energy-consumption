# Use the latest debian base image
FROM debian:latest

# Environment setup
ENV PGDATA=/var/lib/postgresql/data
ENV POSTGRES_USER=hammerdb
ENV POSTGRES_PASSWORD=hammerpw
ENV POSTGRES_DB=tpcc

# Install PostgreSQL
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Prepare PGDATA directory
RUN mkdir -p "$PGDATA" && chown -R postgres:postgres /var/lib/postgresql

# Switch to postgres user
USER postgres

# Initialize DB, create user/db, configure PostgreSQL
RUN /usr/lib/postgresql/*/bin/initdb -D "$PGDATA" && \
    /usr/lib/postgresql/*/bin/pg_ctl -D "$PGDATA" -o "-c listen_addresses='localhost'" -w start && \
    psql --username=postgres --command "CREATE USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';" && \
    psql --username=postgres --command "CREATE DATABASE ${POSTGRES_DB} OWNER ${POSTGRES_USER};" && \
    /usr/lib/postgresql/*/bin/pg_ctl -D "$PGDATA" -m fast -w stop

# Allow external connections
RUN echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf" && \
    echo "host all all all md5" >> "$PGDATA/pg_hba.conf"

# Expose PostgreSQL port
EXPOSE 5432

# Start PostgreSQL server in foreground
CMD ["/usr/lib/postgresql/15/bin/postgres", "-D", "/var/lib/postgresql/data"]