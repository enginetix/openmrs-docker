#!/bin/bash

ADMIN_USER=${ADMIN_USER:admin}
ADMIN_PASS=${ADMIN_PASS:Admin123}
MAX_UPLOAD_SIZE=${MAX_UPLOAD_SIZE:-52428800}
CATALINA_OPTS=${CATALINA_OPTS:-"-Xms128m -Xmx1024m -XX:PermSize=128m -XX:MaxPermSize=256m"}

export CATALINA_OPTS="${CATALINA_OPTS}"

if [ ! -e /etc/.initsuccess ]
then

echo "First start !"

cat << EOF > /usr/local/tomcat/conf/tomcat-users.xml
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
<user username="${ADMIN_USER}" password="${ADMIN_PASS}" roles="admin-gui,manager-gui"/>
</tomcat-users>
EOF

if [ -f "/usr/local/tomcat/webapps/manager/WEB-INF/web.xml" ]
then
	sed -i "s#.*max-file-size.*#\t<max-file-size>${MAX_UPLOAD_SIZE}</max-file-size>#g" /usr/local/tomcat/webapps/manager/WEB-INF/web.xml
	sed -i "s#.*max-request-size.*#\t<max-request-size>${MAX_UPLOAD_SIZE}</max-request-size>#g" /usr/local/tomcat/webapps/manager/WEB-INF/web.xml
fi

touch /etc/.initsuccess
fi

echo "Launch Tomcat and mysql"

service mysql start
/usr/local/tomcat/bin/catalina.sh run
