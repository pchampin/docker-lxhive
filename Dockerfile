FROM ubuntu:15.10

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y mongodb apache2 openssl php5 php5-mongo libapache2-mod-php5 git composer

RUN git clone https://github.com/Brightcookie/lxHive
RUN cd lxHive; composer install

RUN ln -s /lxHive/public /var/www/html/lxHive
RUN mkdir /lxHive/storage; mkdir /lxHive/storage/files; mkdir /lxHive/storage/logs
RUN chown -R www-data /lxHive/storage

RUN a2enmod rewrite
COPY lxHive.conf /etc/apache2/conf-enabled/

COPY start.sh /

EXPOSE 80
VOLUME [ "/var/lib/mongodb", "/lxHive/storage" ]

WORKDIR /lxHive
CMD /start.sh
