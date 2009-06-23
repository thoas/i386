package cc.milkshape.framework
{
	import flash.display.Sprite;
	
	public class Application extends Sprite
	{
		protected static var _instance:Application = null;
		
		public function Application() {
			if(_instance != null) 
				throw new Error("Cannot instance this class a second time, use getInstance instead.");
			_instance = this;
		}
		
		public static function getInstance():Application {
			if(_instance == null)
				new Application();
			return _instance;
		}
	}
}