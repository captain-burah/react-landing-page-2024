# Stage 1: Build (TypeScript compilation)
FROM node:18 AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .  
RUN npm run build

# Stage 2: Serve
FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
