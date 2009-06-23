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
			super(x, y, 0x191919, size);
			_drawCross();
		} 
		
		private function _drawCross():void
		{
			_shape = new Shape();
			_shape.graphics.lineStyle(1, cc.milkshape.utils.Constance.COLOR_BLUE);
			_shape.graphics.moveTo(400, 300);
			_shape.graphics.lineTo(400, 500);
			_shape.graphics.moveTo(300, 400);
			_shape.graphics.lineTo(500, 400);
			
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