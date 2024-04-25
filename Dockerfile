# Stage 1: Build with Python
FROM python:3.8-slim AS build-stage

WORKDIR /app

COPY package*.json ./
RUN npm install

# Stage 2: Final image (no Python)
FROM node:20-alpine  # Adjust Node.js version if needed

WORKDIR /app

COPY --from=build-stage ./node_modules ./node_modules

# Install dependencies
RUN npm install -g node-gyp@latest
RUN npm install -g jest
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
