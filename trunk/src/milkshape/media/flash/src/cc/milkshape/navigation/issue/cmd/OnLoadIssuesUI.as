package cc.milkshape.navigation.issue.cmd
{
	import cc.milkshape.framework.remoting.Gateway;
	import cc.milkshape.navigation.generic.UIList;
	import cc.milkshape.navigation.issue.view.IssuesUI;
	import cc.milkshape.utils.Constance;
	
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;
	import com.bourre.remoting.ServiceMethod;
	
	import flash.events.Event;
	import flash.net.URLRequest;

	public class OnLoadIssuesUI extends AbstractCommand implements Command
	{
		override public function execute(e:Event = null):void
		{
			var gateway:Gateway = Gateway.getInstance(new URLRequest(Constance.GATEWAY_URL));
			var serviceMethod:ServiceMethod = new ServiceMethod('issue.last_issues');
			gateway.addEventListener(serviceMethod, IssuesUI(getView(UIList.ISSUES)).init);
			gateway.callServiceMethod(serviceMethod);
		}
	}
}