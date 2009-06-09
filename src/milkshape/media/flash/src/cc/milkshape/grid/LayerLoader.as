package cc.milkshape.grid
{
	import flash.display.Loader;
	import cc.milkshape.manager.LayerLoaderManager;
	
	public class LayerLoader extends Loader
	{
		private var posX:int;
		private var posY:int;
		public function LayerLoader()
		{
			super();
			LayerLoaderManager.add(this);
		}
	}
}