# FastTables

FastTables is a project that combines FastAPI, Svelte, and DuckDB for fast and efficient data handling.

## How to Use FastTables

To get started with FastTables, follow the steps below:

1. **Build the Docker images:**
   ```bash
   make build
   ```

2. **Bring up the stack:**
   ```bash
   make start
   ```

3. **Init the db schemas and seed them with sample data:**
   ```bash
   make init-db
   ```




## Where\'s it at?
- Access FASTAPI @ http://localhost:8000/docs#/  
- Access LiquidTables UI @ http://localhost/




## Makefile Commands

Below is a list of available `make` commands for managing the Docker images, Kubernetes deployments, and the DuckDB database.

- **Build Commands:**
  - `make build` - Build all Docker images.
  - `make build-fastapi` - Build the FastAPI Docker image.
  - `make build-svelte` - Build the Svelte Docker image.
  - `make build-duckdb` - Build the DuckDB Docker image.

- **Push and Deploy:**
  - `make push` - Tag and push Docker images to the local registry.
  - `make deploy` - Deploy Kubernetes services and deployments.

- **Port Forwarding:**
  - `make port-forward` - Set up port forwarding for services.

- **Database Commands:**
  - `make run-schema` - Run the schema SQL script inside the DuckDB container.
  - `make run-seed` - Run seed data SQL script inside the DuckDB container.
  - `make init-db` - Initialize the database by running the schema and seed SQL scripts.

- **Logs and Cleanup:**
  - `make tail-logs` - Tail logs for all pods.
  - `make stop` - Scale down deployments and stop port forwarding.
  - `make clean-pods` - Delete all Kubernetes pods.
  - `make clean-images` - Remove local Docker images.
  - `make clean` - Stop the stack, clean pods, and remove Docker images.

- **Start the Stack:**
  - `make start` - Build images, deploy services, and start the stack.

- **Help:**
  - `make help` - Display this help message.