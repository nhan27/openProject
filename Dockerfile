FROM centos:7

MAINTAINER pham.channhan@gmail.com 

EXPOSE 8080 

EXPOSE 22

#from https://www.openproject.org/open-source/packaged-installation/packaged-installation-guide/
RUN rpm --import https://rpm.packager.io/key
ADD ./openproject.repo /etc/yum.repos.d/openproject.repo
RUN yum -y install openproject
#need to run openproject configure in shell
