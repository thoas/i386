from square.models import Square, SquareOpen
from pyamf.remoting.gateway.django import DjangoGateway

def echo(request, data):
    return data

services = {
    'square.echo': echo
}

squareGateway = DjangoGateway(services)