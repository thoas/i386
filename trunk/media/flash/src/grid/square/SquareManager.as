package grid.square
{
	public class SquareManager 
	{
		private static var _lstSquare:Array;
		
		public function SquareManager(x:int, y:int)
		{
			_lstSquare = new Array(x);
			for(var i:int = 0; i < x; i++)
			{
				_lstSquare[i] = new Array(y);
			}
		}
		
		public static function add(square:Square):void
		{
			//_lstSquare.push(square);
			_lstSquare[square.X][square.Y] = square;
		}
	}
	
}