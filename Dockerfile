# Stage 1: Build the Angular application
FROM node:14 as build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Stage 2: Serve the built application using Nginx
FROM nginx:1.21-alpine as production-stage

COPY --from=build-stage /app/dist/my-angular-app /usr/share/nginx/html

EXPOSE 6500

CMD ["nginx", "-g", "daemon off;"]
