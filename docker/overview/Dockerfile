# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory within the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the TypeScript source code to the container
COPY . .

# Build the TypeScript code
RUN npm run build

# Expose the port your application will run on (replace with the actual port)
EXPOSE 3000

# Start your TypeScript application (modify the command based on your setup)
CMD [ "node", "./dist/app.js" ]
