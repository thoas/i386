package cc.milkshape.navigation.home
{
    import cc.milkshape.navigation.generic.UIList;
    import cc.milkshape.navigation.generic.PrivateEventList;
    import cc.milkshape.navigation.generic.PluginsServiceList;
    import cc.milkshape.navigation.generic.cmd.LoadApplication;
    import cc.milkshape.navigation.home.view.HomeUI;
    import cc.milkshape.navigation.home.cmd.*;
    import cc.milkshape.framework.remoting.ProxyService;
    import cc.milkshape.navigation.issue.IssuePluginService;
    import cc.milkshape.navigation.profile.ProfilePluginService;

    import com.bourre.plugin.AbstractPlugin;

    import flash.display.MovieClip;
    public class HomePlugin extends AbstractPlugin
    {
        private var _container:MovieClip;

        public function HomePlugin(container:MovieClip)
        {
            super();
            _container = container;
			
            ProxyService.getInstance().registerService(PluginsServiceList.ISSUE, new IssuePluginService(ProxyService.getInstance().gatewayURL));
            ProxyService.getInstance().registerService(PluginsServiceList.PROFILE, new ProfilePluginService(ProxyService.getInstance().gatewayURL));
            getController().pushCommandClass(PrivateEventList.onLoadIssuesHomeUI, OnLoadIssuesHomeUI);
            getController().pushCommandClass(PrivateEventList.loadApplication, LoadApplication);
            getController().pushCommandClass(PrivateEventList.onLoadProfilesHomeUI, OnLoadProfilesHomeUI);
			
            var homeUI:HomeUI = new HomeUI(this, UIList.HOME, container);
        }
    }
}