package cc.milkshape.framework.remoting
{
    import com.bourre.ioc.bean.BeanFactory;
    import com.bourre.log.Logger;
    import com.bourre.log.PixlibStringifier;
    import com.bourre.remoting.AbstractServiceProxy;
    import com.bourre.remoting.ServiceMethod;
    import com.bourre.remoting.ServiceProxyLocator;
    import com.bourre.remoting.ServiceResponder;

    import flash.net.URLRequest;
    public class ProxyService extends ServiceProxyLocator
    {
        private static var _oI:ProxyService;

        public function ProxyService(access:PrivateConstructorAccess)
        {
        }

        public static function getInstance():ProxyService
        {
            if(!_oI) {
                _oI = new ProxyService(new PrivateConstructorAccess());
                var gatewayUrl:String = BeanFactory.getInstance().locate("GATEWAY_URL") as String;
                _oI.gatewayURL = new URLRequest(gatewayUrl);
            }
            return _oI;
        }

        public function defaultRegister(serviceName:String, service:Class):void
        {
            var aps:AbstractServiceProxy = new service(gatewayURL, serviceName) as AbstractServiceProxy;
            registerService(serviceName, aps);
        }

        public function setGateway(s:String):void
        {
            gatewayURL = new URLRequest(s);
        }

        public function toString():String
        {
            return PixlibStringifier.stringify(this);
        }

        public function callServiceMethod(service:AbstractServiceProxy, method:ServiceMethod, sr:ServiceResponder,... rest):void
        {
            Logger.INFO("ProxyService::callServiceMethod");
            Logger.INFO(service.toString() + " -> " + method.toString());
            var args:Array = new Array();
            args.push(method);
            args.push(sr);
            args = args.concat(rest);
            service.callServiceWithResponderOnly.apply(service, args);
        }
    }
}

internal class PrivateConstructorAccess
{
}