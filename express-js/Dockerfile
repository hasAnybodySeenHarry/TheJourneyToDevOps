# Use the official Node.js Alpine image
FROM node:16-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy only necessary application files (excluding node_modules)
COPY index.js index.html ./

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "index.js"]
