package cc.milkshape.grid.square
{
	public class SquareManager 
	{
		private static var _lstSquare:Array = new Array();
		
		public static function getSquares():Array
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