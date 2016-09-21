FROM centos:centos7

MAINTAINER "yuhisa-jp"

ENV SQUID_USERNAME squid
ENV SQUID_PASSWORD squid

RUN yum -y install squid httpd-tools && \
    yum clean all

RUN sed -i 's/http_access deny all/#http_access deny all/g' /etc/squid/squid.conf && \
    sed -i 's/http_port 3128/#http_port 3128/g' /etc/squid/squid.conf && \
    echo "http_port 8080" >> /etc/squid/squid.conf && \
    echo "auth_param digest program /usr/lib64/squid/digest_file_auth /etc/squid/passwd" >> /etc/squid/squid.conf && \
    echo "auth_param digest children 8 startup=8 idle=8" >> /etc/squid/squid.conf && \
    echo "auth_param digest realm proxy" >> /etc/squid/squid.conf && \
    echo "auth_param digest nonce_garbage_interval 5 minutes" >> /etc/squid/squid.conf && \
    echo "auth_param digest nonce_max_duration 30 minutes" >> /etc/squid/squid.conf && \
    echo "auth_param digest nonce_max_count 50" >> /etc/squid/squid.conf && \
    echo "acl pauth proxy_auth REQUIRED" >> /etc/squid/squid.conf && \
    echo "http_access allow pauth" >> /etc/squid/squid.conf && \
    echo "no_cache deny all" >> /etc/squid/squid.conf && \
    
COPY start.sh /start.sh

EXPOSE 8080

CMD ["./start.sh", "-bash"]
