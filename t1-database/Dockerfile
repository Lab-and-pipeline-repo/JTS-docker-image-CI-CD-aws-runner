FROM postgres:latest

# Define arguments for username, password, and database name
ARG POSTGRES_USER=myuser
ARG POSTGRES_PASSWORD=mypassword
ARG POSTGRES_DB=mydatabase

# Set environment variables
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV POSTGRES_DB=$POSTGRES_DB

# Expose the PostgreSQL port
EXPOSE 5432

# Manually create the initialization directory
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy SQL script to create table
COPY init.sql /docker-entrypoint-initdb.d/

# Copy entry point script
COPY execute_init_sql.sh /execute_init_sql.sh
RUN chmod +x /execute_init_sql.sh

# Set custom entry point
ENTRYPOINT ["/execute_init_sql.sh"]
