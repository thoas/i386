package cc.milkshape.framework
{
    import cc.milkshape.framework.events.ApplicationEvent;

    import com.bourre.log.Logger;
    import com.bourre.utils.AirLoggerLayout;

    import flash.display.Sprite;
    import flash.events.Event;

    public class Application extends Sprite
    {
        public function Application(name:String = null, type:Object = null):void
        {
            addEventListener(Event.REMOVED_FROM_STAGE, applicationDisabledHandler);
            Logger.getInstance().addLogListener(AirLoggerLayout.getInstance());
            ApplicationFactory.getInstance().addEventListener(ApplicationEvent.LOADED, type.applicationLoadedHandler);
            ApplicationFactory.getInstance().register(name, type);
        }

        public function applicationLoadedHandler(e:ApplicationEvent):void
        {
            ApplicationFactory.getInstance().removeEventListener(ApplicationEvent.LOADED, this.applicationLoadedHandler);
        }

        public function applicationDisabledHandler(e:Event):void
        {
        }

        protected function _releaseApplication(name:String = null, type:Object = null):void
        {
            ApplicationFactory.getInstance().unregister(name);
        }
    }
}