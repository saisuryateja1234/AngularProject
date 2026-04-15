# Stage 1: Build Angular App
FROM node:18 AS build

WORKDIR /app

# Copy only package files first (Docker cache optimization)
COPY package*.json ./
RUN npm install

# Copy rest of the app
COPY . .

# Build using local Angular CLI
RUN npx ng build --configuration production


# Stage 2: Nginx to serve Angular
FROM nginx:alpine

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# ✅ Copy correct Angular output folder
COPY --from=build /app/dist/routing/browser/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
