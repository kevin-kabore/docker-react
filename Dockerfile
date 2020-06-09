# Specify a base image with a phase name
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- stuff we want for the Run phase

# New FROM statements = new block
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Only copying results in /build directory. Leaving all dev dependencies behind.