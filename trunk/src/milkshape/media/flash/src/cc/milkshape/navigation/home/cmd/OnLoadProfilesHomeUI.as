package cc.milkshape.navigation.home.cmd
{
    import cc.milkshape.framework.remoting.ServerAbstractCommand;
    import cc.milkshape.navigation.generic.UIList;
    import cc.milkshape.navigation.generic.PluginsServiceList;
    import cc.milkshape.navigation.profile.ProfilePluginService;
    import cc.milkshape.framework.remoting.ProxyService;
    import cc.milkshape.navigation.home.view.HomeUI;

    import com.bourre.remoting.events.BasicResultEvent;

    import flash.events.Event;
    public class OnLoadProfilesHomeUI extends ServerAbstractCommand
    {
        override public function execute(e:Event = null):void
        {
            ProfilePluginService(ProxyService.getInstance().locate(PluginsServiceList.PROFILE)).lastProfiles(this); 
        }

        override public function onResult(e:BasicResultEvent):void
        {
            HomeUI(getView(UIList.HOME)).initProfiles(e.getResult());
        }
    }
}