package grid.square
{
	public class SquareDisable extends Square
	{
		public function SquareDisable(x:int, y:int, n:String, w:int = Square.SQUARE_WIDTH, h:int = Square.SQUARE_HEIGHT)
		{
			super(x, y, 0xEEEEEE, n, w, h);
		}
		
	}
}