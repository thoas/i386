package cc.milkshape.utils
{
	public class Constance
	{
		//public static var SCALE_THUMB:Array = new Array(25, 50, 100, 200, 400, 800);
		
		public static var URL_SITE:String = "http://localhost:8000";
		
		public static function url(url:String):String {
			return URL_SITE + "/" + url;
		}
	}
}