package grid.square
{
	public class SquareDisable extends Square
	{
		public function SquareDisable(x:int, y:int, w:int = Square.SQUARE_WIDTH, h:int = Square.SQUARE_HEIGHT)
		{
			super(x, y, 0xEEEEEE, w, h);
		}
		
	}
}