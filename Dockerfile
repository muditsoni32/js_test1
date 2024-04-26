# Base image that includes both Node.js and Python
FROM nikolaik/python-nodejs:python3.8-nodejs14 AS base

WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock) for Node.js
COPY package*.json ./

# Install Node.js dependencies
RUN npm install -g node-gyp
RUN npm install

# Copy your application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
