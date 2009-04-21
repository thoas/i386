package mvc
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import grid.square.Square;
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
		private var _model:GridModel;
		private var _stage:Stage;
		public function GridView(controller:GridController, model:GridModel, stage:Stage)
		{
			_controller = controller;
			_model = model;
			_stage = stage;
			_controller.getData();
			
			_model.addEventListener(SquareEvent.SQUARE_CREATION, _addSquare);
		}

		private function _addSquare(squareEvent:SquareEvent):void
		{
			var square:Square = squareEvent.square;	
			addChild(square);
		}
	}
}