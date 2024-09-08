# Base image
FROM ubuntu:24.10 AS base
ARG DUCKDB_VERSION=v1.0.0

# Stage for amd64 architecture
FROM base AS base-amd64
ARG DUCKDB_ARCH=amd64

# Stage for arm64 architecture
FROM base AS base-arm64
ARG DUCKDB_ARCH=aarch64

# Use the appropriate stage based on build argument
FROM base-${TARGETARCH} AS final

# Install dependencies and download DuckDB CLI
RUN apt-get update \
    && apt-get install -y curl unzip \
    && curl -L -o duckdb_cli.zip "https://github.com/duckdb/duckdb/releases/download/${DUCKDB_VERSION}/duckdb_cli-linux-${DUCKDB_ARCH}.zip" \
    && unzip duckdb_cli.zip \
    && rm duckdb_cli.zip

# Create the directory for the database
RUN mkdir -p /var/lib/duckdb /scripts

# Ensure the database file exists
RUN touch /var/lib/duckdb/mydatabase.db

# Copy the scripts folder into the container
COPY ./scripts /scripts

# Set the DuckDB CLI as the entrypoint with the database file
ENTRYPOINT ["/duckdb", "/var/lib/duckdb/mydatabase.db"]