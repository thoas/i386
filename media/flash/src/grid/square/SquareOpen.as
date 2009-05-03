package grid.square
{	
	public class SquareOpen extends Square
	{	
		public function SquareOpen(x:int, y:int, w:int = SQUARE_WIDTH, h:int = SQUARE_HEIGHT)
		{
			super(x, y, 0x00FF00, w, h);
		}
		
	}
}