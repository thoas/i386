package cc.milkshape.gateway
{
	import flash.net.NetConnection;
	import cc.milkshape.utils.Constance;
	
	public class Gateway extends NetConnection
	{
		protected static var _instance:Gateway = null;
		
		public function Gateway() {
			if(_instance != null) 
				throw new Error("Cannot instance this class a second time, use getInstance instead.");
			_instance = this;
			_instance.connect(Constance.url("gateway/"));
		}
		
		public static function getInstance():Gateway {
			if(_instance == null)
				new Gateway();
			return _instance;
		}
	}
}