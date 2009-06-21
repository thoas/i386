package cc.milkshape.grid
{
	import cc.milkshape.framework.mvc.Model;
	import cc.milkshape.grid.events.GridEvent;
	import cc.milkshape.grid.events.GridFocusEvent;
	import cc.milkshape.grid.events.GridLineEvent;
	import cc.milkshape.grid.events.GridMoveEvent;
	import cc.milkshape.grid.events.GridZoomEvent;
	import cc.milkshape.grid.square.*;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.grid.square.events.SquareFormEvent;

	public class GridModel extends Model 
	{
		private var _issueSlug:String;
		private var _issue:Object;
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		private var _lstPosition:Array;
		private var _focusX:int;
		private var _focusY:int;
		private var _currentScale:int;
		private var _minScale:int;
		private var _maxScale:int;
		private var _gridLineVisible:Boolean;
		private var _posX:int;
		private var _posY:int;
		private var _isShowForm:Boolean;
		
		public function GridModel(issueSlug:String) 
		{ 
			_issueSlug = issueSlug;
		}

		public function get showDisableSquare():int
		{
			return _issue.show_disable_square;
		}

		public function set showDisableSquare(v:int):void
		{
			_issue.show_disable_square = v;
		}

		public function get gridLineVisible():Boolean
		{
			return _gridLineVisible;
		}

		public function get maxScale():int
		{
			return _maxScale;
		}

		public function set maxScale(v:int):void
		{
			_maxScale = v;
		}

		public function get minScale():int
		{
			return _minScale;
		}

		public function set minScale(v:int):void
		{
			_minScale = v;
		}

		public function get focusY():int
		{
			return _focusY;
		}

		public function get focusX():int
		{
			return _focusX;
		}

		public function get squareSize():int
		{
			return _issue.size;
		}

		public function set squareSize(v:int):void
		{
			_issue.size = v;
		}

		public function get posY():int
		{
			return _posY;
		}

		public function set posY(v:int):void
		{
			_posY = v;
		}

		public function get posX():int
		{
			return _posX;
		}

		public function set posX(v:int):void
		{
			_posX = v;
		}

		public function get currentScale():int
		{
			return _currentScale;
		}

		public function get issue():Object
		{
			return _issue;
		}

		public function set issue(issue:Object):void
		{
			_issue = issue;
			_posX = 0;
			_posY = 0;
			_gridLineVisible = true;
			
			dispatchEvent(new GridEvent(GridEvent.INFO_READY, _issue.steps, nbHSquare, nbVSquare, squareSize));
		}

		public function get issueSlug():String
		{
			return _issueSlug;
		}

		public function set issueSlug(v:String):void
		{
			_issueSlug = v;
		}
		
		public function setFocus(x:int, y:int):void {
			focusX = y;
			focusY = x;
		}
		
		public function initSquares(squares:Array, squaresOpen:Array):void
		{
			_lstPosition = new Array(nbHSquare);
			for(var i:int = 0 ; i < nbHSquare ; ++i)
			{
				_lstPosition[i] = new Array(nbVSquare);
			}
			var square:Object;
			for each(square in squares)
			{
				var squareObject:*;
				// si status = false et pas de background alors c'est une booked
				if(!square.status && square.user != null){
					squareObject = new SquareBooked(square.pos_x + minX, square.pos_y + minY, squareSize);
					squareObject.user = square.user;
					_addPosition(squareObject);
				} else {
					if(square.user != null){
						squareObject = new SquareFull(square.pos_x + minX, square.pos_y + minY, square.background_image_path, squareSize);
						squareObject.layers = square.layers;
						squareObject.neighbors = square.neighbors_keys;
						squareObject.user = square.user;
						_addPosition(squareObject);
					}
				}
			}
			
			for each(square in squaresOpen)
			{
				_addPosition(new SquareOpen(square.pos_x + minX, square.pos_y + minY, squareSize));
			}
			/*
			if(showDisableSquare)
			{
				for(i = 0 ; i < nbVSquare ; ++i)
				{
					for(var j:int = 0 ; j < nbHSquare ; ++j)
					{
						if(_lstPosition[i][j] == null)
						{
							_addPosition(new SquareDisable(i, j, squareSize));;
						}
					}
				}
			}*/
			
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
					dispatchEvent(new SquareFormEvent(SquareFormEvent.CLOSE, focusSquare));
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
				var square:Square = focusSquare;
				trace(square);
				if(square is SquareOpen)
				{
					_isShowForm = true;
					dispatchEvent(new SquareFormEvent(SquareFormEvent.SHOW_OPEN, square));
				}
				else if(square is SquareBooked)
				{
					_isShowForm = true;
					dispatchEvent(new SquareFormEvent(SquareFormEvent.SHOW_BOOKED, square));
				}
				else if(_isShowForm)
				{
					_isShowForm = false;
					dispatchEvent(new SquareFormEvent(SquareFormEvent.CLOSE, square));
				}
			}
				
			if(currentScale != minScale)// Si on n'est pas au zoom minimal
			{
				posX = focusX * _issue.steps[currentScale] + _issue.steps[currentScale] / 2;
				posY = focusY * _issue.steps[currentScale] + _issue.steps[currentScale] / 2;
			}
			else
			{
				posX = nbVSquare * _issue.steps[currentScale] / 2;
				posY = nbHSquare * _issue.steps[currentScale] / 2;
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
			dispatchEvent(new GridZoomEvent(GridZoomEvent.ZOOM, scale));
		}
		
		public function set focusX(x:int):void { 
			_focusX = x < 0 ? 0 : x >= nbVSquare ? nbVSquare - 1 : x;
			dispatchEvent(new GridFocusEvent(GridFocusEvent.FOCUS)); 
		}

		public function set focusY(y:int):void {
			_focusY = y < 0 ? 0 : y >= nbHSquare ? nbHSquare - 1 : y;
			dispatchEvent(new GridFocusEvent(GridFocusEvent.FOCUS));
		}
		
		
		public function set gridLineVisible(b:Boolean):void
		{
			_gridLineVisible = b;
			dispatchEvent(new GridLineEvent(b ? GridLineEvent.SHOW : GridLineEvent.HIDE));
		}		
		
		public function get minX():int 
		{ 
			return 0; 
		}
		
		public function get minY():int 
		{ 
			return 0; 
		}
		
		public function get nbHSquare():int 
		{ 
			return _issue.nb_case_x; 
		}
		
		public function get nbVSquare():int 
		{ 
			return issue.nb_case_y; 
		}
		
		public function get focusSquare():* { 
			return SquareManager.get(_lstPosition[_focusY][_focusX]);
		}
		
		public function get currentStep():int
		{
			return _issue.steps[_currentScale];
		}
	}
}