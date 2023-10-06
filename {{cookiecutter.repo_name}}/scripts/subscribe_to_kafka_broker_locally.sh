#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <topic>"
    exit 1
fi

topic="$1"

docker exec -it bitnami_kafka /opt/bitnami/kafka/bin/kafka-console-consumer.sh --consumer.config /opt/bitnami/kafka/config/consumer.properties --bootstrap-server kafka:9092 --topic "$topic" --property print.key=true
