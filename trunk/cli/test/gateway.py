from pyamf.remoting.client import RemotingService

gw = RemotingService('http://127.0.0.1:8000/issue/gateway/')
service = gw.getService('issue')

print service.issue('5x5')