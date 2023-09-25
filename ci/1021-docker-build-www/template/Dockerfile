FROM openos365/openos365-10001-anolisos-7-docker-main-root:latest

# 1
COPY files/ /home/www/files/
RUN chown -R www:www /home/www/files/

# 2
USER www
WORKDIR /home/www
ENV USER=www
ENV HOME=/home/www
RUN /home/www/files/install.sh

# 3
RUN rm -rf /home/www/files/
