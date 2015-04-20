# jgielstra/openmrs

This is a simple docker container based on tomcat 7/java 7/MYSQL 5

## Prerequsites

You'll need a working `docker` CLI and a valid `DOCKER_HOST`.
You should be able to `docker ps` successfully.

## How to use this image

#### Running

This image includes `EXPOSE 8080` the tomcat port.

	docker pull jgielstra/openmrs
	docker run -d -p 8080:8080 -name openmrs 	jgielstra/openmrs
	
#### Backup

The normal MYSQL backup utility can be used

	docker exec -it openmrs mysqldump -uopenmrs -pAdmin123 > backup.sql
	
The database can be recreated via

	docker exec -it openmrs mysql -uopenmrs -pAdmin123 -e "drop database openmrs"
	docker exec -it openmrs mysql -uopenmrs -pAdmin123 -e "create database openmrs"
	mysql -uroot -pAdmin123 openmrs < backup.sql