package cc.milkshape.user
{
	public class User
	{
		private var _attributes:Object;
		private var _authenticated:Boolean;
		protected static var _instance:User = null;
       
		public function User() {
			if(_instance != null) 
				throw new Error("Cannot instance this class a second time, use getInstance instead.");
			_attributes = new Array();
			_instance = this;
		}
		
		public static function getInstance():User {
			if(_instance == null)
				new User();
			return _instance;
		}
 
		public function get authenticated():Boolean
		{
			return _authenticated;
		}

		public function set authenticated(v:Boolean):void
		{
			_authenticated = v;
		}
		
		public function isAuthenticated():Boolean
		{
			return _authenticated;
		}

		public function setAttribute(key:String, data:*):void
		{
			_attributes[key] = data;
		} 
		
		public function getAttribute(key:String):*
		{
			if(hasAttribute(key))
				return _attributes[key];
			return false;	
		}
		
		public function hasAttribute(key:String):Boolean
		{
			return _attributes[key] != null;
		}
		
	}
}