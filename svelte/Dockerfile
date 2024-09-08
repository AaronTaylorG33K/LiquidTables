# Stage 1: Build the Svelte application
FROM node:18 AS build

WORKDIR /app

# Install dependencies
COPY package.json pnpm-lock.yaml ./
RUN npm install -g pnpm && pnpm install

# Copy the application code
COPY . .

# Build the application
RUN pnpm run build

# Stage 2: Serve the Svelte application
FROM nginx:alpine

# Copy built client-side files from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port that nginx will serve on
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
