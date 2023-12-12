# use the official Node.js Alpine image
FROM node:16-alpine

# set the working directory in the container
WORKDIR /usr/src/app

# copy package.json and package-lock.json to the working directory
COPY package*.json ./

# install app dependencies
RUN npm install

# copy the rest of the necessary files to the working directory
COPY index.js index.html ./

# expose the application port
EXPOSE 3000

# command to run the application
CMD ["node", "index.js"]
