package cc.milkshape.framework.remoting
{
	import com.bourre.remoting.AbstractServiceProxy;
	
	import flash.net.URLRequest;
	
	public class Gateway extends AbstractServiceProxy
	{
		protected static var _instance:Gateway = null;
		
		public static function getInstance(sURL:URLRequest):Gateway {
			if(_instance == null)
				new Gateway(sURL);
			return _instance;
		}
		
		public function Gateway(sURL:URLRequest, sServiceName:String=null)
		{
			super(sURL, sServiceName);
			if(_instance != null) 
				throw new Error("Cannot instance this class a second time, use getInstance instead.");
			_instance = this;
		}
	}
}