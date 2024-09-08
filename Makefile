# Define variables for the Docker image names and tags
IMAGE_NAME_FASTAPI = fastapi
IMAGE_NAME_SVELTE = svelte
IMAGE_NAME_DUCKDB = duckdb
TAG = latest
REGISTRY = localhost:5001
NAMESPACE = liquidtables

# Define paths to Dockerfiles
FASTAPI_DOCKERFILE = fastapi/Dockerfile
SVELTE_DOCKERFILE = svelte/Dockerfile
DUCKDB_DOCKERFILE = duckdb/Dockerfile

# Define path to Kubernetes deployments and services files
DEPLOYMENTS_FILE = deployments.yaml
SERVICES_FILE = services.yaml

# Define port forwarding ports
PORT_FASTAPI = 8000
PORT_SVELTE = 3000
PORT_DUCKDB = 5432

# Define paths to SQL files
SCHEMA_FILE := ./duckdb/scripts/schema.sql
SEED_FILE := ./duckdb/scripts/seed.sql

# Define path to local DuckDB container
DUCKDB_CONTAINER_NAME = duckdb-container
DUCKDB_PATH=/usr/local/bin/duckdb

# Build all images
build: build-fastapi build-svelte build-duckdb
	@echo "\033[0;31m🔥 Images ready to go.\033[0m"
	@echo "➡️ Now run \033[0;32m make init-db\033[0m"

# Ensure local Docker registry is running
ensure-registry:
	@if [ -z "$$(docker ps -q -f name=registry)" ]; then \
		echo "Starting local Docker registry..."; \
		docker run -d -p 5001:5000 --name registry registry:2; \
	fi

# Create the namespace if it doesn't exist
create-namespace:
	@if ! kubectl get namespace $(NAMESPACE) > /dev/null 2>&1; then \
		echo "Creating namespace $(NAMESPACE)..."; \
		kubectl create namespace $(NAMESPACE); \
	fi
# Build the FastAPI Docker image
build-fastapi:
	@echo "Building FastAPI Docker image..."
	docker build -t $(IMAGE_NAME_FASTAPI):$(TAG) -f $(FASTAPI_DOCKERFILE) fastapi

# Build the Svelte Docker image
build-svelte:
	@echo "Building Svelte Docker image..."
	docker build -t $(IMAGE_NAME_SVELTE):$(TAG) -f $(SVELTE_DOCKERFILE) svelte

# Build the DuckDB Docker image
build-duckdb:
	@echo "Building DuckDB Docker image..."
	docker build -t $(IMAGE_NAME_DUCKDB):$(TAG) -f $(DUCKDB_DOCKERFILE) duckdb

# Tag and push all Docker images
push: ensure-registry create-namespace
	@echo "Waiting for registry to be fully up..."
	@echo "Tagging and pushing Docker images..."
	docker tag $(IMAGE_NAME_FASTAPI):$(TAG) $(REGISTRY)/$(IMAGE_NAME_FASTAPI):$(TAG)
	docker tag $(IMAGE_NAME_SVELTE):$(TAG) $(REGISTRY)/$(IMAGE_NAME_SVELTE):$(TAG)
	docker tag $(IMAGE_NAME_DUCKDB):$(TAG) $(REGISTRY)/$(IMAGE_NAME_DUCKDB):$(TAG)
	docker push $(REGISTRY)/$(IMAGE_NAME_FASTAPI):$(TAG)
	docker push $(REGISTRY)/$(IMAGE_NAME_SVELTE):$(TAG)
	docker push $(REGISTRY)/$(IMAGE_NAME_DUCKDB):$(TAG)

# Deploy to Kubernetes
deploy:
	@echo "Applying Kubernetes deployments..."
	kubectl apply -f $(DEPLOYMENTS_FILE) -n $(NAMESPACE)
	@echo "Applying Kubernetes services..."
	kubectl apply -f $(SERVICES_FILE) -n $(NAMESPACE)
	@echo "Waiting for pods to be ready..."
	kubectl wait --for=condition=available --timeout=60s deployment/fastapi -n $(NAMESPACE)
	kubectl wait --for=condition=available --timeout=60s deployment/svelte -n $(NAMESPACE)
	kubectl wait --for=condition=available --timeout=60s deployment/duckdb -n $(NAMESPACE)

# Port forward all services
port-forward:
	@echo "Namespace: $(NAMESPACE)"
	@echo "Port forwarding FastAPI..."
	kubectl port-forward service/fastapi $(PORT_FASTAPI):80 -n $(NAMESPACE) &
	@echo "Port forwarding DuckDB..."
	kubectl port-forward service/duckdb $(PORT_DUCKDB):$(PORT_DUCKDB) --address 0.0.0.0 -n $(NAMESPACE) &
	@echo "Port forwarding Svelte..."
	kubectl port-forward service/svelte $(PORT_SVELTE):80 -n $(NAMESPACE) &

# Tail logs for all pods
tail-logs:
	@echo "Tailing logs for FastAPI pods..."
	kubectl logs -f -l app=fastapi -n $(NAMESPACE)
	@echo "Tailing logs for DuckDB pods..."
	kubectl logs -f -l app=duckdb -n $(NAMESPACE)
	@echo "Tailing logs for Svelte pods..."
	kubectl logs -f -l app=svelte -n $(NAMESPACE)

# Scale down all deployments and delete all pods
stop:
	@echo "Scaling down deployments..."
	kubectl scale deployment fastapi --replicas=0 -n $(NAMESPACE)
	kubectl scale deployment svelte --replicas=0 -n $(NAMESPACE)
	kubectl scale deployment duckdb --replicas=0 -n $(NAMESPACE)
	@echo "Stopping port forwarding..."
	pkill -f "kubectl port-forward"
	@echo "Stack stopped."

# Clean up Kubernetes pods
clean-pods:
	@echo "Deleting all pods..."
	kubectl delete pods --all -n $(NAMESPACE)
	@echo "Pods deleted."

# Clean up Kubernetes services
clean-services:
	@echo "Deleting all services..."
	kubectl delete services --all -n $(NAMESPACE)
	@echo "Services deleted."


# Clean up local Docker images
clean-images:
	@echo "Removing local Docker images..."
	docker rmi $(IMAGE_NAME_FASTAPI):$(TAG) $(IMAGE_NAME_SVELTE):$(TAG) $(IMAGE_NAME_DUCKDB):$(TAG)

# Command to start the entire stack
start: push deploy port-forward
	@echo "Opening http://localhost:3000 in the browser..."
	@if ! pgrep -f "open http://localhost:3000" > /dev/null; then \
		open http://localhost:3000; \
	fi
	@echo "🌊 LiquidTables started. Lets goooo!!!"
	@echo ""

# Command to stop and clean the stack
clean:
	@echo "🔥\033[0;31mK\033[0;33mi\033[0;31ml\033[0;33ml\033[0;31m \033[0;33mi\033[0;31mt\033[0;33m \033[0;31mw\033[0;33mi\033[0;31mt\033[0;33mh\033[0;31m \033[0;33mf\033[0;31mi\033[0;33mr\033[0;31me\033[0;33m!\033[0m"
	$(MAKE) stop
	$(MAKE) clean-pods
	$(MAKE) clean-services
	$(MAKE) clean-images

#lolz
kill: clean
	@echo "💀💀💀💀💀"

# First run command
init: build push deploy init-db port-forward
	@echo "Opening http://localhost:3000 in the browser..."
	@if ! pgrep -f "open http://localhost:3000" > /dev/null; then \
		open http://localhost:3000; \
	fi
	@echo "🌊 LiquidTables started. Lets goooo!!!"
	@echo "Run \033[0;32mmake tail-logs\033[0m to view live logs"

# Run schema SQL script inside DuckDB container
run-schema:
	@echo "Running schema SQL script inside DuckDB container..."
	@echo "Current working directory: $(shell pwd)"
	@echo "Checking for schema.sql file at $(SCHEMA_FILE)"
	@ls -l $(SCHEMA_FILE)
	POD_NAME=$$(kubectl get pods -l app=duckdb -n $(NAMESPACE) -o jsonpath='{.items[0].metadata.name}' 2>/dev/null); \
	if [ -z "$$POD_NAME" ]; then \
		echo "No DuckDB pod found in the $(NAMESPACE) namespace."; \
		exit 1; \
	fi; \
	echo "Pod Name: $$POD_NAME"; \
	if [ -f $(SCHEMA_FILE) ]; then \
		kubectl exec -it $$POD_NAME -n $(NAMESPACE) -- sh -c "cat /scripts/schema.sql"; \
		kubectl exec -it $$POD_NAME -n $(NAMESPACE) -- sh -c "/duckdb /var/lib/duckdb/mydatabase.db < /scripts/$(notdir $(SCHEMA_FILE))"; \
		echo -e "\n\033[0;32m🔥 Schema loaded!\033[0m"; \
	else \
		echo "$(SCHEMA_FILE) not found in the local filesystem."; \
		exit 1; \
	fi


# Run seed data SQL script inside DuckDB container
run-seed:
	@echo "Running seed data SQL script inside DuckDB container..."
	POD_NAME=$$(kubectl get pods -l app=duckdb -n $(NAMESPACE) -o jsonpath='{.items[0].metadata.name}' 2>/dev/null); \
	echo "Pod Name: $$POD_NAME"; \
	if [ -z "$$POD_NAME" ]; then \
		echo "No DuckDB pod found in the $(NAMESPACE) namespace."; \
		exit 1; \
	fi; \
	if [ -f $(SEED_FILE) ]; then \
		kubectl exec -it $$POD_NAME -n $(NAMESPACE) -- sh -c "mkdir -p /scripts"; \
		kubectl cp $(SEED_FILE) $$POD_NAME:/scripts/$(notdir $(SEED_FILE)) -n $(NAMESPACE); \
		kubectl exec -it $$POD_NAME -n $(NAMESPACE) -- sh -c "/duckdb /var/lib/duckdb/mydatabase.db < /scripts/$(notdir $(SEED_FILE))"; \
		echo -e "\n\033[0;32m🔥 Database Seeded!\033[0m"; \
	else \
		echo "$(SEED_FILE) not found in the local filesystem."; \
		exit 1; \
	fi


# Initialize the database
init-db: run-schema run-seed
	@echo "\033[0;33m🔥 Databases locked and loaded\033[0m";
	@echo "➡️ Now run \033[0;32m make start\033[0m";

# Display help
help:
	@echo "Makefile commands:"
	@echo "  make build            - Build all Docker images"
	@echo "  make build-fastapi  - Build FastAPI Docker image"
	@echo "  make build-svelte   - Build Svelte Docker image"
	@echo "  make build-duckdb   - Build DuckDB Docker image"
	@echo "  make push           - Tag and push Docker images to local registry"
	@echo "  make deploy         - Deploy Kubernetes services and deployments"
	@echo "  make port-forward   - Set up port forwarding for services"
	@echo "  make run-schema     - Run schema SQL script inside DuckDB container"
	@echo "  make run-seed       - Run seed data SQL script inside DuckDB container"
	@echo "  make tail-logs      - Tail logs for all pods"
	@echo "  make stop           - Scale down deployments and stop port forwarding"
	@echo "  make clean-pods     - Delete all Kubernetes pods"
	@echo "  make clean-services     - Delete all Kubernetes services"
	@echo "  make clean-images   - Remove local Docker images"
	@echo "  make clean          - Stop stack, clean pods, and remove Docker images"
	@echo "  make start          - Build images, deploy services, and start stack"
	@echo "  make init-db        - Initialize database by running SQL scripts"
	@echo "  make help           - Display this help message"
