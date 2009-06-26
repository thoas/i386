package cc.milkshape.grid.square
{	
	import cc.milkshape.utils.Constance;
	
	import flash.display.BlendMode;
	import flash.display.Shape;

	public class SquareOpen extends Square
	{
		private var _shape:Shape;
		
		public function SquareOpen(x:int, y:int, size:int)
		{
			super(x, y, 0x393939, size);
			_drawCross();
		} 
		
		private function _drawCross():void
		{
			_shape = new Shape();
			_shape.graphics.lineStyle(1, cc.milkshape.utils.Constance.COLOR_BLUE);
			
			var i:int = Math.round((3 * _size) / 8); // 300 pour 800
			var j:int = Math.round((5 * _size) / 8); // 500 pour 800
			var k:int = Math.round(_size / 2); // 400 pour 800
			
			_shape.graphics.moveTo(k, i);
			_shape.graphics.lineTo(k, j);
			_shape.graphics.moveTo(i, k);
			_shape.graphics.lineTo(j, k);
			
			_bg.blendMode = BlendMode.DARKEN;
			
			addChild(_shape);
		}
		
		public function showShape():void
		{
			_shape.alpha = 1;
		}
		
		public function hideShape():void
		{
			_shape.alpha = 0;
		}
		
	}
}