package grid
{
	import flash.events.EventDispatcher;
	import grid.square.*;
	
	public class GridModel extends EventDispatcher 
	{
		private var _issueId:int;
		private var _nbVSquare:int;
		private var _nbHSquare:int;
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
		
		public function get nbHSquare():int { return _nbHSquare };
		
		public function get nbVSquare():int { return _nbVSquare };
		
		public function setPosition(squares:Array, squaresOpen:Array, minX:int, minY:int, maxX:int, maxY:int):void
		{
			_maxX = maxX;
			_maxY = maxY;
			_minX = minX < 0 ? minX * -1 : 0;
			_minY = minY < 0 ? minY * -1 : 0;
			_nbHSquare = _maxX + _minX + 1;
			_nbVSquare = _maxY + _minY + 1;
			
			_lstPosition = new Vector.<Array>(_nbHSquare);
			for(var i:int = 0 ; i <= _maxY + 1 ; ++i)
			{
				_lstPosition[i] = new Array(_nbVSquare);
			}
			
			var square:Object;
			for each(square in squares)
			{
				_addPosition(
					square.status ? 
					new SquareFull(square.pos_x + _minX, square.pos_y + _minY, square.background_image_path) : 
					new SquareBooked(square.pos_x + _minX, square.pos_y + _minY)
				);
			}
			for each(square in squaresOpen)
			{
				_addPosition(new SquareOpen(square.pos_x + _minX, square.pos_y + _minY));
			}
			
			dispatchEvent(new GridEvent(GridEvent.GRID_READY));
		}
		
		private function _addPosition(square:Square):void
		{
			_lstPosition[square.X][square.Y] = SquareManager.length() - 1;
			dispatchEvent(new SquareEvent(SquareEvent.SQUARE_CREATION, square));
		}
	}
}