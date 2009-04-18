package grid.square
{
	import grid.Position;
	public class SquareManager 
	{
		private static var _lstSquare:Array = new Array();
		private static var _lstPosition:Array;
		private static var _minX:int = 0;
		private static var _minY:int = 0;
		private static var _maxX:int = 0;
		private static var _maxY:int = 0;
		
		public static function getSquares():Array
		{
			return _lstSquare;
		}
		
		public static function add(square:Square):void
		{
			if(_minX > square.X)
				_minX = square.X;
				
			if(_minY > square.Y)
				_minY = square.Y;
				
			if(_maxX < square.X)
				_maxX = square.X;
				
			if(_maxY < square.Y)
				_maxY = square.Y;
			_lstSquare.push(square);
		}
		
		public static function getPositions():Array
		{
			if(!(_lstPosition is Array))
			{
				_lstPosition = new Array();
				var i:int;
				for(i = 0 ; i < _maxY ; ++i)
				{
					_lstPosition.push(new Array());
				}
				
				
				var square:Square;
				for(i = 0 ; i < _lstSquare.length ; ++i)
				{
					square = _lstSquare[i];
					_lstPosition[square.X + _minX * -1][square.Y + _minY * -1] = i;
					if(square is SquareBooked)
					{
							
					} 
					else if(square is SquareFull)
					{
						
					}
				}
				
				
					
			}
			
			return _lstPosition;
		}
	}
	
}