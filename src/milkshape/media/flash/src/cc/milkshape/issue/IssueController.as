package cc.milkshape.issue
{
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.issue.events.IssuesEvent;
	
	public class IssueController extends GatewayController
	{
		public function lastIssues():void
		{
			Gateway.getInstance().call('issue.last_issues', _responder);
		}
		
		override protected function _onResult(result:Object):void
		{
			dispatchEvent(new IssuesEvent(IssuesEvent.LAST_ISSUES_LOADED, result));
		}
	}
}