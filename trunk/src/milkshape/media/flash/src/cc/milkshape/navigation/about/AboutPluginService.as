package cc.milkshape.navigation.about
{
	import cc.milkshape.framework.remoting.ProxyService;
	import cc.milkshape.framework.remoting.ServerAbstractCommand;
	
	import com.bourre.remoting.AbstractServiceProxy;
	import com.bourre.remoting.ServiceMethod;
	import com.bourre.remoting.ServiceResponder;
	
	import flash.net.URLRequest;
	
	public class AboutPluginService extends AbstractServiceProxy
	{
		protected static const CONTACT:ServiceMethod = new ServiceMethod('about.contact'); 
		public function AboutPluginService(sURL:URLRequest, sServiceName:String=null)
		{
			super(sURL, sServiceName);
		}
		
		public function contact(remoteCommand:ServerAbstractCommand, name:String, email:String, subject:String, message:String):void
		{
			var sr:ServiceResponder = new ServiceResponder(remoteCommand.onResult, remoteCommand.onFault);
			ProxyService.getInstance().callServiceMethod(this, CONTACT, sr, name, email, subject, message);
		} 
	}
}