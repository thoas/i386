package cc.milkshape.grid.process
{
	import flash.display.Sprite;

	public class SquareProcess extends Sprite
	{		
		public function SquareProcess()
		{
			var squareProcessController:SquareProcessController = new SquareProcessController();
			var squareProcessView:SquareProcessView = new SquareProcessView(squareProcessController);
			addChild(squareProcessView);
		}
	}
}