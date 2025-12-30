FROM nginx:alpine
COPY portfolio.html /usr/share/nginx/html/index.html
EXPOSE 80
