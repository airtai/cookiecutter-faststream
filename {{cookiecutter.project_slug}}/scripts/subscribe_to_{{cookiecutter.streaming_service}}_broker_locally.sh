#!/bin/bash

if [ $# -ne 1 ]; then
    {% if 'kafka' in cookiecutter.streaming_service %}
    echo "Usage: $0 <topic>"
    {% endif %}
    {% if 'nats' in cookiecutter.streaming_service %}
    echo "Usage: $0 <subject>"
    {% endif %}
    {% if 'rabbit' in cookiecutter.streaming_service %}
    echo "Usage: $0 <queue>"
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
{% if 'rabbit' in cookiecutter.streaming_service %}
queue="$1"

echo -e "Downloading rabbitmqadmin...\n"
curl -L https://github.com/rabbitmq/rabbitmq-server/blob/main/deps/rabbitmq_management/bin/rabbitmqadmin?raw=true -o rabbitmqadmin
chmod +x rabbitmqadmin

echo -e "Enabling rabbitmq management plugin...\n"
docker exec -it rabbitmq rabbitmq-plugins enable rabbitmq_management
./rabbitmqadmin declare queue name=$queue

echo -e "Fetching messages from $topic queue...\n"
while true; do
    MESSAGE=$(./rabbitmqadmin get queue="$queue" ackmode=ack_requeue_false)
    if [[ $MESSAGE ]]; then
        echo $MESSAGE
    fi

    sleep 2
done

{% endif %}
