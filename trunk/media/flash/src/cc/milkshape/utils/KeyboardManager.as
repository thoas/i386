package cc.milkshape.utils
{
	public class KeyboardManager 
	{
		private static var _enabled:Boolean = true;
		
		public static function set enabled(b:Boolean):void
		{
			_enabled = b;
		}
		
		public static function get enabled():Boolean
		{
			return _enabled;
		}
	}
	
}