package cc.milkshape.grid.process
{
	import flash.display.Sprite;
	import cc.milkshape.grid.process.SquareProcessController;
	import cc.milkshape.grid.GridModel;

	public class SquareProcess extends Sprite
	{		
		public function SquareProcess(gridModel:GridModel)
		{
			var squareProcessController:SquareProcessController = new SquareProcessController(gridModel);
			var squareProcessView:SquareProcessView = new SquareProcessView(gridModel, squareProcessController);
			addChild(squareProcessView);
		}
	}
}