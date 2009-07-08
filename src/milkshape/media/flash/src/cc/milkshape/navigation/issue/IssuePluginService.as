package cc.milkshape.navigation.issue
{
	import cc.milkshape.framework.remoting.ServerAbstractCommand;
	import cc.milkshape.framework.remoting.ProxyService;
	
    import com.bourre.remoting.AbstractServiceProxy;
	import com.bourre.remoting.ServiceMethod;
	import com.bourre.remoting.ServiceResponder;
	
	import flash.net.URLRequest;
	
	public class IssuePluginService extends AbstractServiceProxy
	{
		protected static const LAST_ISSUES:ServiceMethod = new ServiceMethod('issue.last_issues'); 
		public function IssuePluginService(sURL:URLRequest, sServiceName:String=null)
		{
			super(sURL, sServiceName);
		}
		
		public function lastIssues(remoteCommand:ServerAbstractCommand):void
		{
			var sr:ServiceResponder = new ServiceResponder(remoteCommand.onResult, remoteCommand.onFault);
			ProxyService.getInstance().callServiceMethod(this, LAST_ISSUES, sr);
		} 
	}
}