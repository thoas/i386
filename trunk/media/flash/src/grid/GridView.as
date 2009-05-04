package grid
{
	import caurina.transitions.Tweener;	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import grid.square.*;
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
		private var _model:GridModel;
		private var _stage:Stage;
		private var _minScale:int;
		private var _maxScale:int;
		private var _scale:int;
		private var _overX:int;
		private var _overY:int;
		private var _currentScale:int;
		private var _stagePadding:int = 50;
		private var _lineColor:int = 0x1E1E1E;
		private var _scaleThumb:Array = new Array(25, 50, 100, 200, 400, 800);
		private var _speed:Number = 0.8;
		private var _showSquareTimer:Timer;
		
		public function GridView(model:GridModel, controller:GridController, stage:Stage)
		{
			_showSquareTimer = new Timer(2000, 1);
			_controller = controller;
			_model = model;
			_stage = stage;
			_stage.stageFocusRect = false;
			
			_model.addEventListener(SquareEvent.SQUARE_CREATION, _addSquare);
			_model.addEventListener(GridEvent.GRID_READY, _init);
			_controller.getData();
		}
		
		private function _init(e:GridEvent):void
		{
			addChild(new GridLine(_model.nbHSquare, _model.nbVSquare, Square.SQUARE_WIDTH, Square.SQUARE_HEIGHT, _lineColor));
				
			var minSquareWidth:Number = _stage.stageWidth > _stage.stageHeight ? (_stage.stageHeight - _stagePadding) / _model.nbVSquare : (_stage.stageWidth - _stagePadding) / _model.nbHSquare;

			_maxScale = _scaleThumb.length-1;
			for(var i:int = 0; i <= _maxScale; i++)
			{
				if(minSquareWidth >= _scaleThumb[i] && minSquareWidth < _scaleThumb[i+1])// on détermine le pas de zoom minimum
				{
					_minScale = _currentScale = i;
					_model.currentScale = _currentScale;
					_model.update();
					width = _scaleThumb[_minScale] * _model.nbHSquare;
					scaleY = scaleX;
					break;
				}
			}
			
			addEventListener(MouseEvent.CLICK, _onClick);
			addEventListener(MouseEvent.DOUBLE_CLICK, _onDoubleClick);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyDownHandler);
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mouseWheel);
			_stage.addEventListener(Event.RESIZE, _resize);
			
			_resize();
		}
		
		private function _resize(e:Event = null):void
		{
			x = Math.round(_stage.stageWidth / 2 - width / 2);
			y = Math.round(_stage.stageHeight / 2 - height / 2);
		}
		
		private function _zoomTo(op:int):void
		{
			var _futurScale:int = _currentScale + op < _minScale ? _minScale : _currentScale + op > _maxScale ? _maxScale : _currentScale + op;
			
			if(_currentScale != _futurScale)// Si le zoom change
			{
				_currentScale = _futurScale;
				_model.currentScale = _currentScale;
				_model.update();
				Tweener.addTween(
					this,
					{
						width: _scaleThumb[_currentScale] * _model.nbHSquare,
						height: _scaleThumb[_currentScale] * _model.nbVSquare,
						time: _speed,
						transition: 'easeOutSine'
					}
				);
				_moveTo();
			}
		}
		
		private function _moveTo():void
		{
			_showSquareTimer.stop();
			if(_currentScale == _maxScale)
			{
				var square:Square = SquareManager.get(_model.focusSquare);
				if(square is SquareOpen)
				{
					_showSquareTimer.removeEventListener("timer", _showSquareBooked);
            		_showSquareTimer.addEventListener("timer", _showSquareOpen);
            		_showSquareTimer.start();
				}
				else if(square is SquareBooked)
				{
					_showSquareTimer.removeEventListener("timer", _showSquareOpen);
            		_showSquareTimer.addEventListener("timer", _showSquareBooked);
            		_showSquareTimer.start();
				}
			}
			if(_currentScale != _minScale)// Si on n'est pas au zoom minimal
			{	
				Tweener.addTween(
					this,
					{
						x: -_model.focusX * _scaleThumb[_currentScale] + _stage.stageWidth / 2 - _scaleThumb[_currentScale] / 2,
						y: -_model.focusY * _scaleThumb[_currentScale] + _stage.stageHeight / 2 - _scaleThumb[_currentScale] / 2,
						time: _speed,
						transition: 'easeOutSine'
					}
				);
			}
			else// Sinon on replace la grille au centre de la scène
			{
				Tweener.addTween(
					this,
					{
						x: Math.round(_stage.stageWidth / 2 - _model.nbHSquare * _scaleThumb[_currentScale] / 2),
						y: Math.round(_stage.stageHeight / 2 - _model.nbVSquare * _scaleThumb[_currentScale] / 2),
						time: _speed,
						transition: 'easeOutSine'
					}
				);
			}
		}
		
		private function _showSquareOpen(e:TimerEvent):void
		{
			dispatchEvent(new GridEvent(GridEvent.GRID_OPEN_SQUARE));
		}
		
		private function _showSquareBooked(e:TimerEvent):void
		{
			dispatchEvent(new GridEvent(GridEvent.GRID_BOOKED_SQUARE));
		}
		
		private function _addSquare(e:SquareEvent):void
		{
			var square:Square = e.square;
			square.x = square.X * Square.SQUARE_WIDTH;
			square.y = square.Y * Square.SQUARE_HEIGHT;
			square.tabIndex = _model.nbHSquare * square.Y + square.X;// Numéro tabulation = nombre de colonne * y + x
			square.addEventListener(SquareEvent.SQUARE_OVER, _squareOver);
			square.addEventListener(SquareEvent.SQUARE_FOCUS, _squareFocus);// Tabulation
			addChild(square);
		}
		
		private function _squareOver(e:SquareEvent):void
		{
			_overX = e.square.X;
			_overY = e.square.Y;
		}
		
		private function _squareFocus(e:SquareEvent):void
		{
			_model.focusX = e.square.X;
			_model.focusY = e.square.Y;
			
			if(_currentScale != _minScale)// Si on n'est pas au zoom minimal
			{
				_moveTo();
			}
		}
		
		private function _squareMoveTo(X:int, Y:int):void
		{
			_model.focusX = _model.focusX + X < 0 ? 0 : _model.focusX + X >= _model.nbHSquare ? _model.nbHSquare - 1 : _model.focusX + X;
			_model.focusY = _model.focusY + Y < 0 ? 0 : _model.focusY + Y >= _model.nbVSquare ? _model.nbVSquare - 1 : _model.focusY + Y;
			_squarePutFocus();
		}
		
		private function _squarePutFocus():void
		{
			_stage.focus = SquareManager.get(_model.focusSquare);// On mets le focus sur la Square correspondante
		}
		
		private function _onClick(mouseEvent:MouseEvent):void
		{
			_model.focusX = _overX;
			_model.focusY = _overY;
			_zoomTo(mouseEvent.shiftKey ? -1 : 1);	
		}
		
		private function _onDoubleClick(mouseEvent:MouseEvent):void
		{
			_zoomTo(mouseEvent.shiftKey ? -_maxScale : _maxScale);
		}
		
		private function _mouseWheel(mouseEvent:MouseEvent):void
		{
			_model.focusX = _overX;
			_model.focusY = _overY;
			_squarePutFocus();
			_zoomTo(Math.round(mouseEvent.delta/4));
		}
		
		private function _keyDownHandler(e:KeyboardEvent):void
		{
			var boost:int = e.shiftKey ? 2 : 1;
			
			switch(e.keyCode)
			{
				case Keyboard.UP:
				case 87: // W
					_squareMoveTo(0, -1 * boost);
					break;

				case Keyboard.DOWN:
				case 83: // S
					_squareMoveTo(0, 1 * boost);
					break;

				case Keyboard.LEFT:
				case 65: // A
					_squareMoveTo(-1 * boost, 0);
					break;

				case Keyboard.RIGHT:
				case 68: // D
					_squareMoveTo(1 * boost, 0);
					break;

				case Keyboard.PAGE_UP:
					//_pageUpActivated = value;
					break;
					 
				case Keyboard.PAGE_DOWN:
					//_pageDownActivated = value;
					break;

				case Keyboard.HOME:
					//_homeActivated = value;
					break;

				case Keyboard.END:
					//_endActivated = value;
					break;

				case Keyboard.NUMPAD_ADD:
				case 73: // I
					_zoomTo(e.shiftKey ? _maxScale : 1);
					break;

				case Keyboard.NUMPAD_SUBTRACT:
				case 79: // O
					_zoomTo(e.shiftKey ? -_maxScale : -1);
					break;
			  }
		 }
		
	}
}