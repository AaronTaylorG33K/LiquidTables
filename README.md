# LiquidTables

LiquidTables is a project that combines FastAPI, Svelte, and DuckDB for fast and efficient data handling.

<img width="1680" alt="Screenshot 2024-09-14 at 12 50 46 PM" src="https://github.com/user-attachments/assets/8a1199da-ffa1-4ee7-99c3-532296ebff93">


## Prerequesites

Docker, K8s & Make - install it! 


## How to Use LiquidTables


To get started with FastTables, you can either run the `make init` command, or use a more manually controlled process running individual `make` commands.

```bash
make init
```

Kill the stack and remove all pods (don't worry it's in a Namespace)
```bash
make kill
```

The manual equivelent in build commands
- `make build`
- `make start`
- `make init-db`


## All Commands

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
