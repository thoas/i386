package cc.milkshape.contact
{
	import cc.milkshape.gateway.GatewayController;
	
	public class ContactController extends GatewayController
	{
		public function contact(author:String, email:String, subject:String, content:String):void 
		{
			_connect("about/gateway/");
			_gateway.call("about.contact", _responder, author, email, subject, content);
		}
		
		override protected function _onResult(result:Object):void 
		{
		}
	}
}