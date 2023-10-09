#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 {% if 'kafka' in cookiecutter.streaming_service %}<topic>{% endif %}{% if 'nats' in cookiecutter.streaming_service %}<subject>{% endif %}"
    exit 1
fi

{% if 'kafka' in cookiecutter.streaming_service %}topic{% endif %}{% if 'nats' in cookiecutter.streaming_service %}subject{% endif %}="$1"
{% if 'kafka' in cookiecutter.streaming_service %}
docker exec -it bitnami_kafka /opt/bitnami/kafka/bin/kafka-console-consumer.sh --consumer.config /opt/bitnami/kafka/config/consumer.properties --bootstrap-server kafka:9092 --topic "$topic" --property print.key=true
{% endif %}
{% if 'nats' in cookiecutter.streaming_service %}
docker run --rm -it --net=host natsio/nats-box nats sub "$subject"
{% endif %}
