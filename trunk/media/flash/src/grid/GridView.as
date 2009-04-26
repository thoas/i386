package grid
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import caurina.transitions.Tweener;
	import grid.square.Square;
	import grid.square.SquareEvent;
	
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
		private var _model:GridModel;
		private var _stage:Stage;
		private var _scaleThumb:Array = new Array(25, 50, 100, 200, 400, 800);
		private var _minScale:int;
		private var _scale:int;
		
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
			_createBackground();
			
			var stagePadding:int = 50;// facultatif
			var minScaleRelatif:Number = _stage.stageWidth > _stage.stageHeight ? (_stage.stageHeight - stagePadding) / _model.nbVSquare : (_stage.stageWidth - stagePadding) / _model.nbHSquare;
			var nbScales:int = _scaleThumb.length;
			
			for(var i:int = 0; i < nbScales; i++)
			{
				if(minScaleRelatif >= _scaleThumb[i] && minScaleRelatif < _scaleThumb[i+1])// on détermine le pas de zoom minimum
				{
					_minScale = i;
					_scale = i;
					break;
				}
			}
			
			width = _scaleThumb[_scale] * _model.nbHSquare;
			scaleY = scaleX;
			x = Math.round(_stage.stageWidth / 2 - width / 2);
			y = Math.round(_stage.stageHeight / 2 - height / 2);
			
			_zoomTo(2);
			_moveTo(0, 2);
		}
		
		private function _zoomTo(op:int):void
		{
			_scale += op;
			Tweener.addTween(
				this,
				{
					width: _scaleThumb[_scale] * _model.nbHSquare,
					height: _scaleThumb[_scale] * _model.nbVSquare,
					time: 1,
					transition: 'easeOutCubic'
				}
			);
		}
		
		private function _moveTo(X:int, Y:int):void
		{
			Tweener.addTween(
				this,
				{
					x: -X * _scaleThumb[_scale] + _stage.stageWidth / 2 - _scaleThumb[_scale] / 2,
					y: -Y * _scaleThumb[_scale] + _stage.stageHeight / 2 - _scaleThumb[_scale] / 2,
					time: 1,
					transition: 'easeOutCubic'
				}
			);
		}
		
		private function _addSquare(squareEvent:SquareEvent):void
		{
			var square:Square = squareEvent.square;	
			addChild(square);
		}
	}
}