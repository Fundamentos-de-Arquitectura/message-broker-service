cd kafka-infrastructure
docker-compose up -d

Start-Sleep -Seconds 15

docker exec kafka kafka-topics.sh --create `
  --topic orders-events `
  --bootstrap-server localhost:9092 `
  --partitions 3 `
  --replication-factor 1 `
  --if-not-exists

docker exec kafka kafka-topics.sh --create `
  --topic inventory-events `
  --bootstrap-server localhost:9092 `
  --partitions 3 `
  --replication-factor 1 `
  --if-not-exists

Write-Host "Kafka is running!"
Write-Host "Kafka UI: http://localhost:8080"
Write-Host "Bootstrap servers: localhost:9092"