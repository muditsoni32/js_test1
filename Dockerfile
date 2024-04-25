# Use Node.js LTS version as base image
FROM node:lts

# Set the working directory inside the container
WORKDIR /app

RUN apt-get update && apt-get install -y python3

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

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
