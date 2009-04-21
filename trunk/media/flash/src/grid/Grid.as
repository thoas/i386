package grid
{
	import flash.display.MovieClip;
	
	import grid.square.Square;
	import grid.square.SquareBooked;
	import grid.square.SquareFull;

	public class Grid extends MovieClip
	{
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		private var _lstPosition:Vector.<int>;
		
		public function Grid(squares:Array, squaresOpen:Array, minX:int, minY:int, maxX:int, maxY:int)
		{		
			_minX = minX < _minX ? minX:0;
			_minY = minY < _minY ? minX:0;
			_maxX = maxX;
			_maxY = maxY;
			var i:int;
			var ind:int;
			_lstPosition = new Vector.<int>(_maxX - _minX);
			for(i = 0 ; i < _maxY ; ++i){
				_lstPosition.push(new Vector.<int>(maxY - _minY));
			}
			
			for each(var square:Object in squares)
			{
				_addPosition(square.status ? 
						new SquareFull(square.pos_x, square.pos_y, square.background_image_path)
					 	: new SquareBooked(square.pos_x, square.pos_y));
			}
			
			for each(var square:Object in squaresOpen)
			{
				_addPosition(new SquareOpen(square.pos_x, square.pos_y));
			}
					
		}
		
		private function _addPosition(square:Square):void
		{
			addChild(square);
			ind = SquareManager.length() - 1;
			_lstPosition[square.pos_x + _minX * -1][square.pos_y + _minY * -1] = ind;
		}
	}
	
}