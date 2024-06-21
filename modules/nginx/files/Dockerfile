FROM --platform=linux/amd64 nginx:1.27-alpine
COPY ssl/nginx.crt /etc/nginx/ssl/nginx.crt
COPY ssl/nginx.key /etc/nginx/ssl/nginx.key
COPY nginx.conf /etc/nginx/nginx.conf
COPY html/index.html /usr/share/nginx/html/index.html
EXPOSE 80 443
