package mvc
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import grid.square.Square;
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
		private var _model:GridModel;
		private var _stage:Stage;
		public function GridView(model:GridModel, controller:GridController, stage:Stage)
		{
			_controller = controller;
			_model = model;
			_stage = stage;
			_model.addEventListener(SquareEvent.SQUARE_CREATION, _addSquare);
			_controller.getData();
		}

		private function _addSquare(squareEvent:SquareEvent):void
		{
			var square:Square = squareEvent.square;	
			addChild(square);
		}
	}
}