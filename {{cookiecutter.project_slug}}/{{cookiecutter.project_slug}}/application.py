import asyncio
import random

from faststream import FastStream, Logger
from faststream.{{cookiecutter.streaming_service}} import {{cookiecutter.streaming_service | capitalize}}Broker
from pydantic import BaseModel, Field

version = "0.1.0"
title = "My FastStream service"
description = "Description of my FastStream service"


class Name(BaseModel):
    name: str = Field(..., description="Name of the person")


class Greeting(BaseModel):
    greeting: str = Field(..., description="Greeting message")


broker = {{cookiecutter.streaming_service | capitalize}}Broker("localhost:9092")
app = FastStream(broker, title=title, version=version, description=description)

to_greetings = broker.publisher(
    "greetings",
    description="Produces a message on greetings after receiving a meesage on names",
)


@broker.subscriber("names", description="Consumes messages from names topic and produces messages to greetings topic")
async def on_names(msg: Name, logger: Logger) -> None:
    result = f"hello {msg.name}"
    logger.info(result)
    greeting = Greeting(greeting=result)
    await to_greetings.publish(greeting)


@app.after_startup
async def publish_names() -> None:
    async def _publish_names() -> None:
        names = [
            "Ana",
            "Mario",
            "Pedro",
            "João",
            "Gustavo",
            "Joana",
            "Mariana",
            "Juliana",
        ]
        while True:
            name = random.choice(names)  # nosec
            await broker.publish(Name(name=name), topic="names")
            await asyncio.sleep(2)

    asyncio.create_task(_publish_names())
