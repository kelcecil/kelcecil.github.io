FROM nginx:alpine
MAINTAINER Kel Cecil <kelcecil (at) praisechaos.com>

COPY _site /usr/share/nginx/html
EXPOSE 8080
