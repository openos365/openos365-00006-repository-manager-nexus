FROM openanolis/anolisos:7.9-x86_64

# 1
COPY files/ /tmp/files/

# 2
USER root
WORKDIR /root
ENV USER=root
ENV HOME=/root
RUN /tmp/files/install.sh

# 3
RUN rm -rf /tmp/files/
