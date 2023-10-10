#!/bin/bash

if [ $# -ne 1 ]; then
    {% if 'kafka' in cookiecutter.streaming_service %}
    echo "Usage: $0 <topic>"
    {% endif %}
    {% if 'nats' in cookiecutter.streaming_service %}
    echo "Usage: $0 <subject>"
    {% endif %}
    exit 1
fi

{% if 'kafka' in cookiecutter.streaming_service %}
topic="$1"

docker exec -it bitnami_kafka /opt/bitnami/kafka/bin/kafka-console-consumer.sh --consumer.config /opt/bitnami/kafka/config/consumer.properties --bootstrap-server kafka:9092 --topic "$topic" --property print.key=true
{% endif %}
{% if 'nats' in cookiecutter.streaming_service %}
subject="$1"

docker run --rm -it --net=host natsio/nats-box nats sub "$subject"
{% endif %}
