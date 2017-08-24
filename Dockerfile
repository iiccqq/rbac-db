FROM mysql:5.7
VOLUME /tmp
ADD my.cnf  /etc/mysql/mysql.conf.d/mysqld.cnf

ADD init.sql  /docker-entrypoint-initdb.d/

