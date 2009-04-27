package grid
{
	import caurina.transitions.Tweener;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import grid.square.Square;
	import grid.square.SquareEvent;
	
	import flash.events.MouseEvent;
	
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
		private var _model:GridModel;
		private var _stage:Stage;
		private var _scaleThumb:Array = new Array(25, 50, 100, 200, 400, 800);
		private var _minScale:int;
		private var _maxScale:int;
		private var _scale:int;
		private var _squareFocusX:int;
		private var _squareFocusY:int;
		private var _currentX:int;
		private var _currentY:int;
		private var _currentScale :int;
		
		public function GridView(model:GridModel, controller:GridController, stage:Stage)
		{
			_controller = controller;
			_model = model;
			_stage = stage;	
			
			_model.addEventListener(SquareEvent.SQUARE_CREATION, _addSquare);
			_model.addEventListener(GridEvent.GRID_READY, _initGrid);
			_controller.getData();
		}
		
		private function _createBackground():void
		{
			var nbVSquare:int = _model.nbVSquare;
            var nbHSquare:int = _model.nbHSquare;
            
			var bg:Shape = new Shape();
            bg.graphics.lineStyle(1, 0x888888);// mémo : LineScaleMode.VERTICAL
           
            for(var i:int = 0; i <= nbVSquare; i++)
  			{
  				bg.graphics.lineTo(i * Square.SQUARE_HEIGHT, Square.SQUARE_HEIGHT * nbVSquare);
            	bg.graphics.moveTo((i+1) * Square.SQUARE_HEIGHT, 0);
 			}
 			
 			bg.graphics.moveTo(0, 0);
 			
            for(var j:int = 0; j <= nbHSquare; j++)
  			{
  				bg.graphics.lineTo(Square.SQUARE_WIDTH * nbHSquare, j * Square.SQUARE_WIDTH);
            	bg.graphics.moveTo(0, (j+1) * Square.SQUARE_WIDTH);
 			}
 			
            addChild(bg);
		}
		
		private function _initGrid(gridEvent:GridEvent):void
		{
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mouseWheel);
			addEventListener(MouseEvent.CLICK, _onClick);
			addEventListener(MouseEvent.DOUBLE_CLICK, _onDoubleClick);
			
			_currentX = 1;
			_currentY = 1;
			_createBackground();
			
			var stagePadding:int = 50;// facultatif
			var minScaleRelatif:Number = _stage.stageWidth > _stage.stageHeight ? (_stage.stageHeight - stagePadding) / _model.nbVSquare : (_stage.stageWidth - stagePadding) / _model.nbHSquare;
			_maxScale = _scaleThumb.length-1;
			
			for(var i:int = 0; i <= _maxScale; i++)
			{
				if(minScaleRelatif >= _scaleThumb[i] && minScaleRelatif < _scaleThumb[i+1])// on détermine le pas de zoom minimum
				{
					_minScale = i;
					_currentScale = i;
					break;
				}
			}
			
			_initZoom();
		}
		
		private function _initZoom():void
		{
			width = _scaleThumb[_minScale] * _model.nbHSquare;
			scaleY = scaleX;
			x = Math.round(_stage.stageWidth / 2 - width / 2);
			y = Math.round(_stage.stageHeight / 2 - height / 2);
		}
		
		private function _zoomTo(op:int):void
		{
			var _futurScale:int = _currentScale + op < _minScale ? _minScale : _currentScale + op > _maxScale ? _maxScale : _currentScale + op;
			if(_currentScale != _futurScale)
			{
				_currentScale = _futurScale;
				Tweener.addTween(
					this,
					{
						width: _scaleThumb[_currentScale] * _model.nbHSquare,
						height: _scaleThumb[_currentScale] * _model.nbVSquare,
						time: 1,
						transition: 'easeOutSine'
					}
				);
				_moveTo();
			}
			
			
		}
		
		private function _moveTo():void
		{
			_currentX = _squareFocusX;
			_currentY = _squareFocusY;
			Tweener.addTween(
				this,
				{
					x: -_currentX * _scaleThumb[_currentScale] + _stage.stageWidth / 2 - _scaleThumb[_currentScale] / 2,
					y: -_currentY * _scaleThumb[_currentScale] + _stage.stageHeight / 2 - _scaleThumb[_currentScale] / 2,
					time: 1,
					transition: 'easeOutSine'
				}
			);
		}
		
		private function _addSquare(squareEvent:SquareEvent):void
		{
			var square:Square = squareEvent.square;
			square.addEventListener(SquareEvent.SQUARE_FOCUS, _squareFocus);
			square.addEventListener(SquareEvent.SQUARE_MOVE, _squareMove);// Tabulation
			addChild(square);
		}
		
		private function _squareFocus(squareEvent:SquareEvent):void
		{
			_squareFocusX = squareEvent.square.X;
			_squareFocusY = squareEvent.square.Y;
		}
		
		private function _squareMove(squareEvent:SquareEvent):void
		{
			_moveTo();
		}
		
		private function _onClick(mouseEvent:MouseEvent):void
		{
			_zoomTo(mouseEvent.shiftKey ? -1 : 1);
		}
		
		private function _onDoubleClick(mouseEvent:MouseEvent):void
		{
			_zoomTo(mouseEvent.shiftKey ? -_maxScale : _maxScale);
		}
		
		private function _mouseWheel(mouseEvent:MouseEvent):void
		{
			_zoomTo(Math.round(mouseEvent.delta/4));
		}
	}
}