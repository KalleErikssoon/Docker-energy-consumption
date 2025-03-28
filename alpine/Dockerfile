# Use the latest Alpine base image
FROM alpine:latest

# Set environment variables
ENV PGDATA=/var/lib/postgresql/data
ENV POSTGRES_USER=hammerdb
ENV POSTGRES_PASSWORD=hammerpw
ENV POSTGRES_DB=tpcc

# Install PostgreSQL and needed utilities
RUN apk update && \
    apk add --no-cache postgresql postgresql-contrib su-exec

# Create required directories and set permissions (as root)
RUN mkdir -p "$PGDATA" /run/postgresql && \
    chown -R postgres:postgres /var/lib/postgresql /run/postgresql

# 🔻 Now switch to the postgres user
USER postgres

# Initialize database and create users and databases
RUN mkdir -p /run/postgresql && \
    chown -R postgres:postgres /run/postgresql && \
    /usr/bin/initdb -D "$PGDATA" && \
    /usr/bin/pg_ctl -D "$PGDATA" -o "-c listen_addresses='localhost'" -w start && \
    # Set password for postgres user (used in TPC-H)
    psql --username=postgres --command "ALTER USER postgres WITH PASSWORD 'postgres';" && \
    # Create hammerdb user and tpcc db for TPC-C
    psql --username=postgres --command "CREATE USER hammerdb WITH PASSWORD 'hammerpw';" && \
    psql --username=postgres --command "CREATE DATABASE tpcc OWNER hammerdb;" && \
    # Create tpch db for TPC-H
    psql --username=postgres --command "CREATE DATABASE tpch OWNER postgres;" && \
    /usr/bin/pg_ctl -D "$PGDATA" -m fast -w stop



# Allow external connections
RUN echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf" && \
    echo "host all all all md5" >> "$PGDATA/pg_hba.conf"

# Expose PostgreSQL default port
EXPOSE 5432

# Start PostgreSQL server in foreground
CMD ["/usr/bin/postgres", "-D", "/var/lib/postgresql/data"]
