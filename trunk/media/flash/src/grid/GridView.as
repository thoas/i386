package grid
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import grid.square.Square;
	import grid.square.SquareEvent;
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
		private var _model:GridModel;
		private var _stage:Stage;
		private var _background:Sprite;
		
		public function GridView(model:GridModel, controller:GridController, stage:Stage)
		{
			_background = new Sprite();
			addChild(_background);
			
			_controller = controller;
			_model = model;
			_stage = stage;
			_model.addEventListener(SquareEvent.SQUARE_CREATION, _addSquare);
			_model.addEventListener(GridEvent.GRID_READY, _initGrid);
			_controller.getData();
		}
		
		private function _initGrid(gridEvent:GridEvent):void
		{
			var stagePadding:int = 50;
			var backgroundPadding:int = 200;
			var negativeWidth:int = Square.SQUARE_WIDTH * _model.minX - backgroundPadding;
			var negativeHeight:int = Square.SQUARE_HEIGHT * _model.minY - backgroundPadding;
						
			_background.alpha = 0.2;
			_background.graphics.beginFill(0x222222);
			_background.graphics.drawRect(negativeWidth, negativeHeight, width + backgroundPadding * 2, height + backgroundPadding * 2);
			_background.graphics.endFill();
			
			
			if(_stage.stageWidth > _stage.stageHeight)
			{
				height = _stage.stageHeight - stagePadding;
				scaleX = scaleY;
			}
			else
			{
				width = _stage.stageWidth - stagePadding;
				scaleY = scaleX;
			}
			
			x = _stage.stageWidth / 2 - negativeWidth * scaleX - width / 2;
			y = _stage.stageHeight / 2 - negativeHeight * scaleY - height / 2;	
		}
		
		private function _addSquare(squareEvent:SquareEvent):void
		{
			var square:Square = squareEvent.square;	
			addChild(square);
		}
	}
}