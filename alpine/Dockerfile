# Use the latest alpine base image
FROM alpine:latest

# Install PostgreSQL
RUN apk update && \
    apk add --no-cache postgresql postgresql-contrib

# Expose default PostgreSQL port
EXPOSE 5432 

# Create default data directory
RUN mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql

# Use default PostgreSQL user
USER postgres

# Default command
CMD ["postgres", "-D", "/var/lib/postgresql/data"]