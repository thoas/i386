package cc.milkshape.grid
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import cc.milkshape.utils.Constance;
	
	public class Layer extends Sprite
	{
		private var _lstImage:Array;
		private var _scale:int;
		
		public function Layer(scale:int)
		{
			_scale = scale;
			_lstImage = new Array();			
		}
		
		public function addThumb(bitmap:Bitmap, x:int, y:int):void
		{
			bitmap.width *= 800 / Constance.SCALE_THUMB[_scale];
			bitmap.height *= 800 / Constance.SCALE_THUMB [_scale];
			bitmap.x = x * 800;
			bitmap.y = y * 800;
			_lstImage.push(bitmap);
			addChild(bitmap);
		}

	}
}