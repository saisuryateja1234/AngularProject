# Step 1: Build Angular App
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install -g @angular/cli
RUN npm install

COPY . .

RUN ng build --configuration production

# Step 2: Nginx Serving
FROM nginx:alpine

# REMOVE DEFAULT NGINX PAGE
RUN rm -rf /usr/share/nginx/html/*

# ✅ COPY YOUR DIST OUTPUT
COPY --from=build /app/dist/AngularProject/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
