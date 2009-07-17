package cc.milkshape.navigation.home.cmd
{
    import cc.milkshape.framework.remoting.ServerAbstractCommand;
    import cc.milkshape.navigation.generic.UIList;
    import cc.milkshape.navigation.generic.PluginsServiceList;
    import cc.milkshape.navigation.issue.IssuePluginService;
    import cc.milkshape.framework.remoting.ProxyService;
    import cc.milkshape.navigation.home.view.HomeUI;

    import com.bourre.remoting.events.BasicResultEvent;

    import flash.events.Event;
    public class OnLoadIssuesHomeUI extends ServerAbstractCommand
    {
        override public function execute(e:Event = null):void
        {
            IssuePluginService(ProxyService.getInstance().locate(PluginsServiceList.ISSUE)).lastIssues(this); 
        }

        override public function onResult(e:BasicResultEvent):void
        {
            HomeUI(getView(UIList.HOME)).initIssues(e.getResult());
        }
    }
}