FROM mariadb:10.3.3
ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE mydb
EXPOSE 3306

COPY mydb.sql.tar.gz /
COPY initialize.sh /
COPY startup.sh /

RUN /initialize.sh

ENTRYPOINT ["/startup.sh"]
