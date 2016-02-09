FROM centos:7

MAINTAINER pham.channhan@gmail.com 

EXPOSE 8080 

EXPOSE 22

#from https://www.openproject.org/open-source/packaged-installation/packaged-installation-guide/
RUN rpm --import https://rpm.packager.io/key
ADD ./openproject.repo /etc/yum.repos.d/openproject.repo

#from driveup/openproject
RUN yum --setopt=tsflags=nodocs -y install \
    memcached \
    mysql-server \
    mysql-client \
    python-setuptools \
    openproject-ce \
    && rm -rf /var/cache/yum/* \
    && yum clean all
#RUN easy_install supervisor
ENV DATABASE_URL=mysql2://root:123p4s5w0rd@127.0.0.1:3306/openproject ENV SECRET_TOKEN=c5aa99a90f9650404a900cf5ec7c28f7fe1379550bb811cb0b39058f9400eaa216b9b2b22d27f58fb15ac21adb3bd16494ebe89e39ec225ef4627db048a12530
ENV ADMIN_EMAIL=admin@gmail.com ENV EMAIL_DELIVERY_METHOD=smtp ENV SMTP_DOMAIN=smtp.gmail.com ENV SMTP_HOST=smtp.gmail.com ENV SMTP_PASSWORD=yourpassword ENV SMTP_PORT=587 ENV SMTP_USERNAME=yourusername ENV SMTP_URL=smtp://$SMTP_USERNAME:$SMTP_PORT@$SMTP_HOST:$SMTP_PORT/$SMTP_DOMAIN ADD ./mysqlStartup.sh /opt/openproject-ce/mysqlStartup.sh
RUN /bin/bash /opt/openproject-ce/mysqlStartup.sh
RUN /usr/bin/openproject-ce config:set DATABASE_URL=${DATABASE_URL} \
    && /usr/bin/openproject-ce config:set SECRET_TOKEN=${SECRET_TOKEN} \
    && /usr/bin/openproject-ce config:set ADMIN_EMAIL=${ADMIN_EMAIL} \
    && /usr/bin/openproject-ce config:set EMAIL_DELIVERY_METHOD=${EMAIL_DELIVERY_METHOD} \
    && /usr/bin/openproject-ce config:set SMTP_DOMAIN=${SMTP_DOMAIN} \
    && /usr/bin/openproject-ce config:set SMTP_HOST=${SMTP_HOST} \
    && /usr/bin/openproject-ce config:set SMTP_PASSWORD=${SMTP_PASSWORD} \
    && /usr/bin/openproject-ce config:set SMTP_PORT=${SMTP_PORT} \
    && /usr/bin/openproject-ce config:set SMTP_USERNAME=${SMTP_USERNAME} \
    && /usr/bin/openproject-ce config:set SMTP_URL=smtp://${SMTP_USERNAME}:${SMTP_PORT}@${SMTP_HOST}:${SMTP_PORT}/${SMTP_DOMAIN}
#ADD ./openprojectStartup.sh /opt/openproject-ce/openprojectStartup.sh
#RUN /bin/bash /opt/openproject-ce/openprojectStartup.sh
#ADD ./supervisord/ /etc/supervisord/
#EXPOSE 3000 CMD /usr/bin/supervisord --configuration=/etc/supervisord/supervisord.conf

#old:
#RUN yum -y install openproject
#need to run openproject configure in shell
