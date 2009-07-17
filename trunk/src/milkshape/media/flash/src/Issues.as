package
{   
    import cc.milkshape.framework.Application;
    import cc.milkshape.framework.events.ApplicationEvent;
    import cc.milkshape.navigation.generic.ApplicationList;
    import cc.milkshape.navigation.generic.ChannelList;
    import cc.milkshape.navigation.generic.PluginsList;
    import cc.milkshape.navigation.issue.IssuesPlugin;
    
    import com.bourre.events.ApplicationBroadcaster;
    import com.bourre.events.EventBroadcaster;
    import com.bourre.events.EventChannel;
    import com.bourre.ioc.bean.BeanFactory;
    import com.bourre.plugin.ChannelExpert;
    
    import com.bourre.plugin.PluginEvent;
    import flash.events.Event;

    public class Issues extends Application
    {
        public function Issues()
        {   
            super(ApplicationList.ISSUES, this);
        }
        
        override public function applicationLoadedHandler(e:ApplicationEvent):void
        {
            super.applicationLoadedHandler(e);
            var container:IssuesClp = new IssuesClp();
            
            ChannelExpert.getInstance().registerChannel(new EventChannel(ChannelList.ISSUES));
            var issues:IssuesPlugin = new IssuesPlugin(container);
            BeanFactory.getInstance().register(PluginsList.ISSUES, issues);
            EventBroadcaster.getInstance().addListener(issues.getController());
            ApplicationBroadcaster.getInstance().addListener(this, issues.getChannel());
            
            addChild(container);
        }
        
        override public function applicationDisabledHandler(e:Event):void
        {
            EventBroadcaster.getInstance().removeListener(BeanFactory.getInstance().locate(PluginsList.ISSUES).getController());
            _releaseApplication(ApplicationList.ISSUES, this);
            BeanFactory.getInstance().locate(PluginsList.ISSUES).release();
        }
        
        public function onReleasePlugin(e:PluginEvent):void
        {
            BeanFactory.getInstance().unregister(PluginsList.ISSUES);
        }
    }
}