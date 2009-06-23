package cc.milkshape.grid.square
{
	import cc.milkshape.utils.Constance;
	import flash.display.BlendMode;

	import flash.display.Shape;

	public class SquareBooked extends SquareOwned
	{
		private var _shape:Shape;

		public function SquareBooked(x:int, y:int, size:int)
		{
			super(x, y, 0xFF0000, size);
			_drawCross();
		}
		
		private function _drawCross():void
		{
			_shape = new Shape();
			_shape.graphics.lineStyle(1, cc.milkshape.utils.Constance.COLOR_YELLOW);
			_shape.graphics.moveTo(300, 300);
			_shape.graphics.lineTo(500, 500);
			_shape.graphics.moveTo(500, 300);
			_shape.graphics.lineTo(300, 500);
			
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