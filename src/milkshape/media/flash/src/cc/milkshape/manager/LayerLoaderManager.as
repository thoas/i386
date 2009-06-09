package cc.milkshape.manager
{
	import cc.milkshape.grid.LayerLoader;

	public class LayerLoaderManager
	{
		private static var _layers:Array;
		
		public static function add(layerLoader:LayerLoader)
		{
			_layers.push(layerLoader);
		}
	}
}