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
		private var _focusX:int;
		private var _focusY:int;
		private var _squareSize:int;
		private var _currentScale:int;
		private var _minScale:int;
		private var _maxScale:int;
		
		public function GridModel(issueId:int) 
		{ 
			_issueId = issueId;
		}
		
		public function init(squares:Array, squaresOpen:Array, minX:int, minY:int, maxX:int, maxY:int, nbHSquare:int, nbVSquare:int, showDisableSquare:int, squareSize:int):void
		{
			_maxX = maxX;
			_maxY = maxY;
			_minX = minX < 0 ? minX * -1 : 0;
			_minY = minY < 0 ? minY * -1 : 0;
			_nbHSquare = nbHSquare ? nbHSquare : _maxX + _minX + 1;
			_nbVSquare = nbVSquare ? nbVSquare : _maxY + _minY + 1;
			_squareSize = squareSize;
			
			_lstPosition = new Vector.<Array>(_nbHSquare);
			for(var i:int = 0 ; i < _nbHSquare ; ++i)
			{
				_lstPosition[i] = new Array(_nbVSquare);
			}
			
			var square:Object;
			for each(square in squares)
			{
				_addPosition(
					square.status ? 
					new SquareFull(square.pos_x + _minX, square.pos_y + _minY, square.background_image_path, this) : 
					new SquareBooked(square.pos_x + _minX, square.pos_y + _minY)
				);
			}
			for each(square in squaresOpen)
			{
				_addPosition(new SquareOpen(square.pos_x + _minX, square.pos_y + _minY));
			}
			
			if(showDisableSquare)
			{
				for(i = 0 ; i < _nbHSquare ; ++i)
				{
					for(var j:int = 0 ; j < _nbVSquare ; ++j)
					{
						if(_lstPosition[i][j] == null)
						{
							_addPosition(new SquareDisable(i, j));;
						}
					}
				}
			}
			dispatchEvent(new GridEvent(GridEvent.GRID_READY, _currentScale));
		}
		
		private function _addPosition(square:Square):void
		{
			_lstPosition[square.X][square.Y] = SquareManager.length() - 1;
			dispatchEvent(new SquareEvent(SquareEvent.SQUARE_CREATION, square));
		}
		
		public function update():void { dispatchEvent(new GridEvent(GridEvent.GRID_UPDATE, _currentScale)) }
		
		public function set currentScale(scale:int):void { 
			_currentScale = scale 
			dispatchEvent(new GridEvent(GridEvent.GRID_UPDATE, _currentScale))
		}
		
		public function get minScale():int { return _minScale }
		
		public function get maxScale():int { return _maxScale }
		
		public function get currentScale():int { return _currentScale; }
		
		public function get issueId():int { return _issueId }
		
		public function get minX():int { return _minX }
		
		public function get minY():int { return _minY }
		
		public function get nbHSquare():int { return _nbHSquare }
		
		public function get nbVSquare():int { return _nbVSquare }
		
		public function get focusX():int { return _focusX }
		
		public function get focusY():int { return _focusY }
		
		public function set focusX(x:int):void { _focusX = x }
		
		public function set squareSize(squareSize:int):void { _squareSize = squareSize }
		
		public function set minScale(minScale:int):void { _minScale = minScale }
		
		public function set maxScale(maxScale:int):void { _maxScale = maxScale }		
		
		public function get squareSize():int { return _squareSize }
		
		public function set focusY(y:int):void { _focusY = y }
		
		public function get focusSquare():int { return _lstPosition[_focusX][_focusY] }
	}
}