FROM docker.elastic.co/logstash/logstash:8.6.2

# Download JDBC connector for Logstash
RUN curl -L --retry 5 --output "mysql-connector-j-8.0.32.tar.gz" "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-8.0.32.tar.gz"
RUN tar -xf "mysql-connector-j-8.0.32.tar.gz"
RUN mv "mysql-connector-j-8.0.32/mysql-connector-j-8.0.32.jar" "mysql-connector-j-8.0.32.jar"
RUN rm -r "mysql-connector-j-8.0.32" "mysql-connector-j-8.0.32.tar.gz"

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
