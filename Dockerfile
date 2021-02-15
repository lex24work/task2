FROM debian:stable-20210208-slim

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y nginx \
    && apt-get clean

RUN rm -rf /var/www/*

RUN mkdir -p /var/www/company.com/img

COPY index.html /var/www/company.com/
COPY img.png /var/www/company.com/img/

RUN useradd alex
RUN groupadd surovsk
RUN usermod -a alex -G surovsk
RUN chown -R alex:surovsk /var/www/company.com

RUN sed -i 's#/var/www/html#/var/www/company.com#g' /etc/nginx/sites-enabled/default
RUN sed -i 's/www-data/alex/g' /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]