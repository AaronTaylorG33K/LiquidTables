# LiquidTables

LiquidTables is a project that combines FastAPI, Svelte, and DuckDB for fast and efficient data handling.

## REFACTOR IN THE WORKS ON BRANCH `refactoring for reusability`

The new one is based on being a re-usable component that builds its columns and rows ambigiously. This one also resembles a classic spreadsheet a bit better. Much better code than on `main`
<img width="1056" alt="Screenshot 2024-09-11 at 9 05 28 PM" src="https://github.com/user-attachments/assets/56516d5f-f7ef-4d1e-83c3-6f808f05d57f">





## PROTOTYPE BUILD `main`

This was not done with any sort of best practice in mind when building the front end, it was a rapid prototype for proof of concept. This currently supports bidirectional websocket communication.

<img width="925" alt="Screenshot 2024-09-10 at 2 33 36 PM" src="https://github.com/user-attachments/assets/af9f9fa9-2e98-4ae1-adee-a0e626777275">

## Prerequesites

Docker & K8s, install it! 


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
