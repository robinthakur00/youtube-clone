# # Use an official Node.js runtime as a parent image
# FROM node:16

# # Set the working directory in the container
# WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
# COPY package*.json ./

# # Install app dependencies, including Material-UI 5
# RUN npm install

# # Copy the rest of the application code to the working directory
# COPY . .

# # Build the React app
# RUN npm run build

# # Expose the port that the app will run on (adjust if needed)
# EXPOSE 3000

# # Define the command to start the app
# CMD ["npm", "start"]

# Stage 1: Build the React app
FROM node:16 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the built React app with a lightweight server
FROM node:16-alpine

WORKDIR /app

COPY --from=build /app/build ./build
COPY package*.json ./
RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", "build"]

