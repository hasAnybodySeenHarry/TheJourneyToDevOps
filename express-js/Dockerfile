# Build stage
FROM node:16-alpine AS build

WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install --only prod

# Copy all application files
COPY . .

# Production stage
FROM node:16-alpine

WORKDIR /usr/src/app

# Copy only necessary files from the build stage
COPY --from=build /usr/src/app/index.js /usr/src/app/index.html ./
COPY --from=build /usr/src/app/node_modules ./node_modules

# Expose the application port
EXPOSE 3000

# Command to run the application
CMD ["node", "index.js"]

