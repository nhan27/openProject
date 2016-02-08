FROM centos:7

MAINTAINER pham.channhan@gmail.com 

EXPOSE 8080 

EXPOSE 22

#from https://www.openproject.org/open-source/packaged-installation/packaged-installation-guide/
RUN rpm --import https://rpm.packager.io/key
RUN echo "[openproject]
name=Repository for opf/openproject-ce application.
baseurl=https://rpm.packager.io/gh/opf/openproject-ce/centos7/stable/5
enabled=1" | sudo tee /etc/yum.repos.d/openproject.repo
RUN yum install openproject
#need to run openproject configure in shell
