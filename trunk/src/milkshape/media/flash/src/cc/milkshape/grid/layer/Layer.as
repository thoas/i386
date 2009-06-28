package cc.milkshape.grid.layer
{
	import cc.milkshape.utils.Constance;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class Layer extends Sprite
	{
		private var _lstImage:Array;
		private var _scale:int;
		
		public function Layer(scale:int)
		{
			_scale = scale;
			_lstImage = new Array();			
		}
		
		public function addThumb(bitmap:Bitmap, x:int, y:int, size:int, currentScale:int):void
		{
			bitmap.width *= size / currentScale;
			bitmap.height *= size / currentScale;
			bitmap.x = x * bitmap.width;
			bitmap.y = y * bitmap.height;
			_lstImage.push(bitmap);
			addChild(bitmap);
		}
	}
}