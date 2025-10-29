FROM confluentinc/cp-kafka:7.5.0

ENV KAFKA_BROKER_ID=1
ENV KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181

CMD ["sh", "-c", "kafka-server-start.sh /etc/kafka/server.properties"]