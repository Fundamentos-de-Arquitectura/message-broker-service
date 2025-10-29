# Kafka Infrastructure

Kafka message broker setup for the microservices platform.

## Overview

This repository contains the Docker Compose configuration for running Apache Kafka and supporting services.

### Services

- **Kafka**: Message broker (Port 9092)
- **Zookeeper**: Kafka coordinator (Port 2181)
- **Kafka UI**: Web interface for monitoring (Port 8080)

## Quick Start

### Start Kafka Infrastructure
```bash
docker-compose up -d
```

Kafka will be available at `localhost:9092`

### Stop Kafka Infrastructure
```bash
docker-compose down
```

### View Kafka UI

Open browser: `http://localhost:8080`

## Topics

The following topics are auto-created by microservices:

- `orders-events`: Order creation and cancellation events
- `inventory-events`: Inventory availability and stock updates

## Integration with Microservices

### Orders Service Configuration
```properties
spring.kafka.bootstrap-servers=localhost:9092
spring.kafka.producer.value-serializer=org.springframework.kafka.support.serializer.JsonSerializer
kafka.topic.orders-events=orders-events
```

### Inventory Service Configuration
```properties
spring.kafka.bootstrap-servers=localhost:9092
spring.kafka.consumer.group-id=inventory-service-group
spring.kafka.consumer.value-deserializer=org.springframework.kafka.support.serializer.JsonDeserializer
kafka.topic.orders-events=orders-events
kafka.topic.inventory-events=inventory-events
```

## Monitoring

### Using Kafka UI

1. Open `http://localhost:8080`
2. View brokers, topics, and consumer groups
3. Monitor message flow in real-time

### Using CLI
```bash
# List topics
docker exec kafka kafka-topics.sh --list --bootstrap-server localhost:9092

# Create topic manually
docker exec kafka kafka-topics.sh --create \
  --topic my-topic \
  --bootstrap-server localhost:9092 \
  --partitions 3 \
  --replication-factor 1

# View messages
docker exec kafka kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic orders-events \
  --from-beginning
```

## Development Commands
```bash
# Start in background
docker-compose up -d

# View real-time logs
docker-compose logs -f

# Stop all services
docker-compose down

# Remove volumes (fresh start)
docker-compose down -v

# Restart specific service
docker-compose restart kafka
```

## Production Considerations

- Use persistent volumes for data
- Set up multiple Kafka brokers for high availability
- Configure proper retention policies
- Use network security and authentication
- Monitor broker performance and disk usage
- Set up backups for critical topics