import pytest
from faststream.{{cookiecutter.streaming_service}} import Test{{cookiecutter.streaming_service | capitalize}}Broker

from {{cookiecutter.project_slug}}.application import Greeting, Name, broker, on_names


@broker.subscriber("greetings")
async def on_greetings(msg: Greeting) -> None:
    pass


@pytest.mark.asyncio
async def test_on_names():
    async with Test{{cookiecutter.streaming_service | capitalize}}Broker(broker):
        await broker.publish(Name(name="John"), "names")
        on_names.mock.assert_called_with(dict(Name(name="John")))
        on_greetings.mock.assert_called_with(dict(Greeting(greeting="hello John")))
