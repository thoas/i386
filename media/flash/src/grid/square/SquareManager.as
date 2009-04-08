package src.grid.square
{
	public class SquareManager 
	{
		private static var _lstSquare:Array = new Array();
		
		public static function add(square:Square)
		{
			_lstSquare.push(square);
		}
	}
	
}