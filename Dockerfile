FROM nginx:alpine
COPY potfolio.html /usr/share/nginx/html/index.html
EXPOSE 80
