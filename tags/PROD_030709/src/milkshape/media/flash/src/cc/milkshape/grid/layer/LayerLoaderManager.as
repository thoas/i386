package cc.milkshape.grid.layer
{
	import flash.display.Bitmap;

	public class LayerLoaderManager
	{
		private static var _layers:Object = new Object();
		
		public static function add(url:String, thumb:Bitmap):void
		{
			_layers[url] = thumb;
		}
		
		public static function contains(url:String):Boolean
		{
			return _layers[url] != null;
		}
	}
}