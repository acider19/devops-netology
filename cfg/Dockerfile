FROM nginx:1.29.0

COPY ./index.html /usr/share/nginx/html/index.html

EXPOSE 80/tcp

ENTRYPOINT ["nginx", "-g", "daemon off;"]
