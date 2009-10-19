package cc.milkshape.framework
{
    import cc.milkshape.framework.events.ApplicationEvent;
    import cc.milkshape.utils.Constance;

    import com.bourre.core.AbstractLocator;
    import com.bourre.ioc.bean.BeanFactory;
    import com.bourre.load.XMLLoader;
    import com.bourre.load.XMLLoaderEvent;

    import flash.net.URLRequest;
    public class ApplicationFactory extends AbstractLocator
    {
        private static var _oI:ApplicationFactory;
        private static var _isConfigLoaded:Boolean = false;

        public static function getInstance():ApplicationFactory
        {
            if(!_oI) 
                _oI = new ApplicationFactory(new PrivateConstructorAccess());
            return _oI;
        }

        public function ApplicationFactory(access:PrivateConstructorAccess)
        {
            super();
            var loader:XMLLoader = new XMLLoader();
            loader.addEventListener(XMLLoaderEvent.onLoadInitEVENT, _onLoaded);
            loader.load(new URLRequest(BeanFactory.getInstance().locate("ASSETS_URL") + "/constance.xml"));
        }

        private function _onLoaded(e:XMLLoaderEvent):void
        {
            var xmlContent:XML = e.getXML() as XML;
            var results:XMLList = xmlContent.elements('item');
            var beanFactory:BeanFactory = BeanFactory.getInstance();
            for each(var item:XML in results) {
                getLogger().debug(item.key + " -> " + item.value);
                beanFactory.register(String(item.key), String(item.value));
            }
            _isConfigLoaded = true;
            broadcastEvent(new ApplicationEvent(ApplicationEvent.LOADED));
        }

        override public function register(name:String, o:Object):Boolean
        {
            if(_isConfigLoaded)
                broadcastEvent(new ApplicationEvent(ApplicationEvent.LOADED));
            return super.register(name, o);
        }
    }
}

internal class PrivateConstructorAccess
{
}