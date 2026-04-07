# Step 1: Build Angular Application
FROM node:18 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install -g @angular/cli
RUN npm install

# Copy all project files
COPY . .

# Build angular app for production
RUN ng build --configuration production

# Step 2: Serve using NGINX
FROM nginx:alpine

# Copy build output to nginx html folder
COPY --from=build /app/dist/ /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
