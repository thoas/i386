package grid.square
{
	public class SquareManager 
	{
		private static var _lstSquare:Vector.<Square> = new Vector.<Square>();
		
		public static function getSquares():Vector
		{
			return _lstSquare;
		}
		
		public static function add(square:Square):void
		{
			_lstSquare.push(square);
		}
		
		public static function length():int
		{
			return _lstSquare.length;
		}
		
		public static function get(i:int):Square
		{
			return _lstSquare[i];
		}
	}
	
}