# Stage 1: Build with Python
FROM python:3.8-slim AS build-stage

WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Stage 2: Final image (no Python)
FROM node:20-alpine AS final-stage

WORKDIR /app

# Copy Node.js dependencies from the build-stage
COPY --from=build-stage /app/node_modules ./node_modules

# Install global Node.js dependencies
RUN npm install -g node-gyp@latest jest

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
