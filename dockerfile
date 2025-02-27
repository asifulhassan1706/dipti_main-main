FROM node:20-alpine AS builder

WORKDIR /app

COPY package* .

RUN npm i

COPY . .

RUN npm run build

FROM nginx:1.27.0-alpine-slim

COPY --from=builder /app/dist /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]