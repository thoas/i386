package grid.square
{
	public class SquareBooked extends Square
	{
		public function SquareBooked(x:int, y:int, n:String, w:int = Square.SQUARE_WIDTH, h:int = Square.SQUARE_HEIGHT)
		{
			super(x, y, 0xFF0000, n, w, h);
		}
		
	}
}