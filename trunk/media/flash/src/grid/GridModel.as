package grid
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import grid.square.*;
	
	public class GridModel extends EventDispatcher 
	{
		private var _issueId:int;
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		private var _lstPosition:Vector.<Array>;
	
		public function GridModel(issueId:int) 
		{ 
			_issueId = issueId;
		}
		
		public function get issueId():int
		{
			return _issueId;
		}
		
		public function get minX():int { return _minX };
		
		public function get minY():int { return _minY };
		
		public function setPosition(squares:Array, squaresOpen:Array, minX:int, minY:int, maxX:int, maxY:int):void
		{		
			_minX = minX < _minX ? minX:0;
			_minY = minY < _minY ? minX:0;
			_maxX = maxX;
			_maxY = maxY;
			var i:int;
			var ind:int;
			_lstPosition = new Vector.<Array>(_maxX - _minX + 1);
			for(i = 0 ; i <= _maxY + 1 ; ++i)
			{
				_lstPosition[i] = new Array(_maxY - _minY + 1);
			}
			var square:Object;
			for each(square in squares)
			{
				_addPosition(square.status ? 
						new SquareFull(square.pos_x, square.pos_y, square.background_image_path)
					 	: new SquareBooked(square.pos_x, square.pos_y));
			}
			
			for each(square in squaresOpen)
			{
				_addPosition(new SquareOpen(square.pos_x, square.pos_y));
			}
			
			dispatchEvent(new GridEvent(GridEvent.GRID_READY));
		}
		
		private function _addPosition(square:Square):void
		{
			var ind:int = SquareManager.length() - 1;
			_lstPosition[square.X + _minX * -1][square.Y + _minY * -1] = ind;
			dispatchEvent(new SquareEvent(SquareEvent.SQUARE_CREATION, square));
		}
	}
}