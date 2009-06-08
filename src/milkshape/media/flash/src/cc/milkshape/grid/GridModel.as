package cc.milkshape.grid
{
	import cc.milkshape.framework.Model;
	import cc.milkshape.grid.square.*;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.grid.square.events.SquareFormEvent;
	import cc.milkshape.utils.Constance;
	import flash.events.EventDispatcher;
	
	import cc.milkshape.grid.events.GridEvent;
	import cc.milkshape.grid.events.GridLineEvent;

	import cc.milkshape.grid.events.GridFocusEvent;

	import cc.milkshape.grid.events.GridMoveEvent;

	import cc.milkshape.grid.events.GridZoomEvent;

	public class GridModel extends Model 
	{
		private var _issueId:int;
		private var _nbVSquare:int;
		private var _nbHSquare:int;
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		private var _lstPosition:Array;
		private var _focusX:int;
		private var _focusY:int;
		private var _squareSize:int;
		private var _currentScale:int;
		private var _minScale:int;
		private var _maxScale:int;
		private var _showDisableSquare:int;
		private var _gridLineVisible:Boolean;
		private var _posX:int;
		private var _posY:int;
		private var _isShowForm:Boolean;
		
		public function GridModel(issueId:int) 
		{ 
			_issueId = issueId;
		}
		
		public function init(minX:int, minY:int, maxX:int, maxY:int, nbHSquare:int, nbVSquare:int, showDisableSquare:int, squareSize:int):void
		{
			_posX = 0;
			_posY = 0;
			_gridLineVisible = true;
			_showDisableSquare = showDisableSquare;
			_maxX = maxX;
			_maxY = maxY;
			_minX = minX < 0 ? minX * -1 : 0;
			_minY = minY < 0 ? minY * -1 : 0;
			_nbHSquare = nbHSquare ? nbHSquare : _maxX + _minX + 1;
			_nbVSquare = nbVSquare ? nbVSquare : _maxY + _minY + 1;
			_squareSize = squareSize;
			
			dispatchEvent(new GridEvent(GridEvent.INFO_READY, _nbHSquare, _nbVSquare, _squareSize));
		}
		
		public function setFocus(x:int, y:int):void {
			focusX = x;
			focusY = y;
		}
		
		public function initSquares(squares:Array, squaresOpen:Array):void
		{
			_lstPosition = new Array(_nbHSquare);
			for(var i:int = 0 ; i < _nbHSquare ; ++i)
			{
				_lstPosition[i] = new Array(_nbVSquare);
			}
			var square:Object;
			for each(square in squares)
			{
				_addPosition(
					square.status ? 
					new SquareFull(square.pos_x + _minX, square.pos_y + _minY, square.background_image_path, _squareSize) : 
					new SquareBooked(square.pos_x + _minX, square.pos_y + _minY, _squareSize)
				);
			}
			for each(square in squaresOpen)
			{
				_addPosition(new SquareOpen(square.pos_x + _minX, square.pos_y + _minY, _squareSize));
			}
			
			if(_showDisableSquare)
			{
				for(i = 0 ; i < _nbHSquare ; ++i)
				{
					for(var j:int = 0 ; j < _nbVSquare ; ++j)
					{
						if(_lstPosition[i][j] == null)
						{
							_addPosition(new SquareDisable(i, j, _squareSize));;
						}
					}
				}
			}
			
			dispatchEvent(new GridEvent(GridEvent.READY));
		}

		public function zoomTo(op:int):void
		{			
			var futurScale:int = currentScale + op < minScale ? minScale : currentScale + op > maxScale ? maxScale : currentScale + op;
			
			if(currentScale != futurScale)// Si le zoom change
			{
				if(_isShowForm)
				{
					_isShowForm = false;
					dispatchEvent(new SquareFormEvent(SquareFormEvent.CLOSE));
				}
				currentScale = futurScale;
				dispatchEvent(new GridZoomEvent(GridZoomEvent.ZOOM, futurScale));
				moveTo();
			}
		}
		
		public function moveTo():void
		{
			if(currentScale == maxScale)// Si on est au zoom maximal
			{
				var square:Square = SquareManager.get(focusSquare);
				if(square is SquareOpen)
				{
					_isShowForm = true;
					dispatchEvent(new SquareFormEvent(SquareFormEvent.SHOW_OPEN));
				}
				else if(square is SquareBooked)
				{
					_isShowForm = true;
					dispatchEvent(new SquareFormEvent(SquareFormEvent.SHOW_BOOKED));
				}
				else if(_isShowForm)
				{
					_isShowForm = false;
					dispatchEvent(new SquareFormEvent(SquareFormEvent.CLOSE));
				}
			}
				
			if(currentScale != minScale)// Si on n'est pas au zoom minimal
			{
				posX = focusX * Constance.SCALE_THUMB[currentScale] + Constance.SCALE_THUMB[currentScale] / 2;
				posY = focusY * Constance.SCALE_THUMB[currentScale] + Constance.SCALE_THUMB[currentScale] / 2;
			}
			else
			{
				posX = nbVSquare * Constance.SCALE_THUMB[currentScale] / 2;
				posY = nbHSquare * Constance.SCALE_THUMB[currentScale] / 2;
			}
			
			dispatchEvent(new GridMoveEvent(GridMoveEvent.MOVE, posX, posY));
		}
		
		private function _addPosition(square:Square):void
		{
			_lstPosition[square.X][square.Y] = SquareManager.length() - 1;
			dispatchEvent(new SquareEvent(SquareEvent.CREATION, square));
		}
		
		public function set currentScale(scale:int):void { 
			_currentScale = scale;
		}
		
		public function set focusX(x:int):void { 
			_focusX = x < 0 ? 0 : x >= _nbHSquare ? _nbHSquare - 1 : x;
			dispatchEvent(new GridFocusEvent(GridFocusEvent.FOCUS)); 
		}

		public function set focusY(y:int):void {
			_focusY = y < 0 ? 0 : y >= _nbVSquare ? _nbVSquare - 1 : y;
			dispatchEvent(new GridFocusEvent(GridFocusEvent.FOCUS));
		}
		
		public function set squareSize(squareSize:int):void { _squareSize = squareSize }
		
		public function set minScale(minScale:int):void { _minScale = minScale }
		
		public function set maxScale(maxScale:int):void { _maxScale = maxScale }
		
		public function set posX(x:int):void { _posX = x }		
		
		public function get posX():int { return _posX }
		
		public function set posY(y:int):void { _posY = y }		
		
		public function get posY():int { return _posY }
		
		public function set gridLineVisible(b:Boolean):void
		{
			_gridLineVisible = b;
			dispatchEvent(new GridLineEvent(b ? GridLineEvent.SHOW : GridLineEvent.HIDE));
		}		
		
		public function get gridLineVisible():Boolean { return _gridLineVisible }		
		
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
		
		public function get squareSize():int { return _squareSize }
		
		public function get focusSquare():int { 
			return _lstPosition[_focusX][_focusY];
		}
	}
}