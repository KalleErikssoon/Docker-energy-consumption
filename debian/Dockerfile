# Use the latest debian base image
FROM debian:latest

# Install PostgreSQL and clean up
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose default PostgreSQL port
EXPOSE 5432 

# Use default PostgreSQL user
USER postgres

# Start PostgreSQL

CMD ["/usr/lib/postgresql/15/bin/postgres", "-D", "/var/lib/postgresql/data"]
