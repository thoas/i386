package grid
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import grid.square.*;
	
	import utils.Constance;
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
		private var _model:GridModel;
		private var _minScale:int;
		private var _maxScale:int;
		private var _scale:int;
		private var _currentScale:int;
		private var _stagePadding:int;
		private var _lineColor:int;
		private var _scaleThumb:Array;
		private var _speed:Number;
		private var _showSquareTimer:Timer;
		
		public function GridView(model:GridModel, controller:GridController)
		{
			_lineColor = 0x1E1E1E;
			_stagePadding = 50;
			_speed = 0.8;
			
			_controller = controller;
			_model = model;
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{					
			_showSquareTimer = new Timer(2000, 1);	
			_model.addEventListener(SquareEvent.SQUARE_CREATION, _addSquare);
			_model.addEventListener(GridEvent.GRID_READY, _handlerGridReady);
			_controller.getData();
		}
		
		private function _handlerGridReady(e:GridEvent):void
		{
			addChild(new GridLine(_model.nbHSquare, _model.nbVSquare, Square.SQUARE_WIDTH, Square.SQUARE_HEIGHT, _lineColor));

			var scales:Array = _controller.defineScale(stage.stageWidth, stage.stageHeight, _stagePadding);
			_minScale = _currentScale = scales['minScale'];
			_maxScale = scales['maxScale'];
			
			width = Constance.SCALE_THUMB[_minScale] * _model.nbHSquare;
			scaleY = scaleX;
			
			_model.addEventListener(GridEvent.GRID_PUT_FOCUS, _squarePutFocus);
			_model.addEventListener(GridEvent.GRID_MOVE, _moveTo);
			_model.addEventListener(GridEvent.GRID_UPDATE, _zoomTo);
			addEventListener(MouseEvent.CLICK, _controller.onClick);
			addEventListener(MouseEvent.DOUBLE_CLICK, _controller.onDoubleClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _controller.keyDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, _controller.mouseWheel);
			stage.addEventListener(Event.RESIZE, _resize);
			
			_resize();
		}
		
		private function _resize(e:Event = null):void
		{
			x = Math.round(stage.stageWidth / 2 - width / 2);
			y = Math.round(stage.stageHeight / 2 - height / 2);
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
			square.addEventListener(SquareEvent.SQUARE_OVER, _controller.squareOver);
			square.addEventListener(SquareEvent.SQUARE_FOCUS, _controller.squareFocus);// Tabulation
			addChild(square);
		}
		
		private function _zoomTo(e:GridEvent):void
		{
			_currentScale = e.currentScale;
			Tweener.addTween(
				this,
				{
					width: Constance.SCALE_THUMB[_currentScale] * _model.nbHSquare,
					height: Constance.SCALE_THUMB[_currentScale] * _model.nbVSquare,
					time: _speed,
					transition: 'easeOutSine'
				}
			);
			_moveTo();
		}
		
		private function _moveTo(e:GridEvent = null):void
		{
			_showSquareTimer.stop();
			if(_currentScale == _maxScale)
			{
				var square:Square = _controller.getFocusSquare();
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
						x: -_model.focusX * Constance.SCALE_THUMB[_currentScale] + stage.stageWidth / 2 - Constance.SCALE_THUMB[_currentScale] / 2,
						y: -_model.focusY * Constance.SCALE_THUMB[_currentScale] + stage.stageHeight / 2 - Constance.SCALE_THUMB[_currentScale] / 2,
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
						x: Math.round(stage.stageWidth / 2 - _model.nbHSquare * Constance.SCALE_THUMB[_currentScale] / 2),
						y: Math.round(stage.stageHeight / 2 - _model.nbVSquare * Constance.SCALE_THUMB[_currentScale] / 2),
						time: _speed,
						transition: 'easeOutSine'
					}
				);
			}
		}
		
		private function _squarePutFocus(e:GridEvent):void
		{
			stage.focus = _controller.getFocusSquare();// On mets le focus sur la Square correspondante
		}
	}
}