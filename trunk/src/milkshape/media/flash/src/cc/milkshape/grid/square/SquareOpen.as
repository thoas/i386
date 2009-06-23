package cc.milkshape.grid.square
{	
	import flash.display.BlendMode;

	public class SquareOpen extends Square
	{	
		public function SquareOpen(x:int, y:int, size:int)
		{
			super(x, y, 0x191919, size);
			blendMode = BlendMode.OVERLAY;
		}
		
	}
}