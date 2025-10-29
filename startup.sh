#!/bin/bash

echo "Starting Kafka Infrastructure..."
docker-compose up -d

echo "Waiting for Kafka to be ready..."
sleep 15

echo "Kafka is running!"
echo "Kafka UI: http://localhost:8080"
echo "Bootstrap servers: localhost:9092"

echo "Creating topics..."
docker exec kafka kafka-topics.sh --create \
  --topic orders-events \
  --bootstrap-server localhost:9092 \
  --partitions 3 \
  --replication-factor 1 \
  --if-not-exists

docker exec kafka kafka-topics.sh --create \
  --topic inventory-events \
  --bootstrap-server localhost:9092 \
  --partitions 3 \
  --replication-factor 1 \
  --if-not-exists

echo "Topics created!"