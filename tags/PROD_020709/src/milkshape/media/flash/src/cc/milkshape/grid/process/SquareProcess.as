package cc.milkshape.grid.process
{
	import cc.milkshape.grid.GridModel;
	import cc.milkshape.grid.process.events.SquareProcessEvent;
	
	import flash.display.Sprite;

	public class SquareProcess extends Sprite
	{
		private var _squareProcessView:SquareProcessView;
		
		public function SquareProcess(gridModel:GridModel)
		{
			var squareProcessController:SquareProcessController = new SquareProcessController();
			_squareProcessView = new SquareProcessView(gridModel, squareProcessController);
			squareProcessController.addEventListener(SquareProcessEvent.SHOW, _show);
			squareProcessController.addEventListener(SquareProcessEvent.HIDE, _hide)
		}
		
		private function _show(e:SquareProcessEvent):void
		{
			addChild(_squareProcessView);
		}
		
		private function _hide(e:SquareProcessEvent):void
		{
			if(contains(_squareProcessView))
				removeChild(_squareProcessView);
		}
	}
}