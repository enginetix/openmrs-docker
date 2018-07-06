FROM tomcat:7.0.88-jre7
MAINTAINER Johan Gielstra "jgielstra@yahoo.com"

RUN apt-get update
RUN apt-get install curl
RUN apt-get -f install

RUN echo mysql-server mysql-server/root_password password Admin123 | debconf-set-selections;\
  echo mysql-server mysql-server/root_password_again password Admin123 | debconf-set-selections;\
  apt-get install -y mysql-server

# get platform war
RUN curl -sL http://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_1.11.2/openmrs.war/download -o /usr/local/tomcat/webapps/openmrs.war

# get and install modules
RUN curl -sL http://sourceforge.net/projects/openmrs/files/releases/OpenMRS_2.2/openmrs-2.2-modules.zip/download -o /root/mods.zip && mkdir -p /usr/local/tomcat/openmrs/modules  && unzip -j -d /usr/local/tomcat/openmrs/modules /root/mods.zip && rm /root/mods.zip

ADD init_db.sh /tmp/init_db.sh
ADD openmrs_jg.sql /tmp/openmrs_jg.sql
RUN /bin/bash /tmp/init_db.sh

# copy default cofig 
ADD openmrs-runtime.properties /usr/local/tomcat/openmrs-runtime.properties
ADD start.sh /root/start.sh
RUN chmod +x /root/start.sh
EXPOSE 8080

CMD ["/root/start.sh"]
