package cc.milkshape.grid
{
	import cc.milkshape.grid.events.GridMoveEvent;
	import cc.milkshape.grid.events.GridOverEvent;
	import cc.milkshape.grid.square.SquareManager;
	import cc.milkshape.grid.square.SquareOwned;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.manager.KeyboardManager;
	
	import flash.events.MouseEvent;

	public class GridMouseController
	{
		private var _gridModel:GridModel;
		private var _pointClickX:int;
		private var _pointClickY:int;
		private var _clickEnabled:Boolean;
		
		public function GridMouseController(gridModel:GridModel)
		{
			_pointClickX = 0;
			_pointClickY = 0;
			_clickEnabled = true;
			_gridModel = gridModel;
		}
		
		public function mouseDownMagnet(e:MouseEvent):void
		{
			_pointClickX = e.stageX;
			_pointClickY = e.stageY;
		}
		
		public function mouseUpMagnet(e:MouseEvent):void
		{
			if(_gridModel.currentScale != _gridModel.minScale)// Si on n'est pas au zoom maximal
			{
				_gridModel.posX += (_pointClickX - e.stageX) * _gridModel.currentScale / 2;
				_gridModel.posY += (_pointClickY - e.stageY) * _gridModel.currentScale / 2;
				
				_gridModel.dispatchEvent(new GridMoveEvent(GridMoveEvent.MOVE, _gridModel.posX, _gridModel.posY));
			}
		}
		
		public function rollOverHandler(e:SquareEvent):void
		{ 
			_gridModel.overX = e.square.X;
			_gridModel.overY = e.square.Y;

			if(_gridModel.overSquare is SquareOwned)
			{
				_gridModel.dispatchEvent(new GridOverEvent(GridOverEvent.OVER, SquareOwned(_gridModel.overSquare).user.id));
			}
			
			_clickEnabled = (_gridModel.focusY == _gridModel.overX  && _gridModel.focusX == _gridModel.overY);
		}		
		
		public function mouseWheelHandler(e:MouseEvent):void
		{
			_gridModel.setFocus(_gridModel.overX, _gridModel.overY);
			_gridModel.zoomTo(Math.round(e.delta/4));
		}
		
		public function clickHandler(e:MouseEvent):void
		{
			KeyboardManager.enabled = true;
			if(_clickEnabled || _gridModel.currentScale == _gridModel.minScale)
			{
				_gridModel.zoomTo(e.shiftKey ? -1 : 1);
			}
			_clickEnabled = (_gridModel.focusY == _gridModel.overX && _gridModel.focusX == _gridModel.overY);
		}
		
		public function stageClickHandler(mouseEvent:MouseEvent):void
		{
			_gridModel.zoomTo(-1);
		}
		
		public function stageDoubleClickHandler(mouseEvent:MouseEvent):void
		{
			_gridModel.zoomTo(-_gridModel.maxScale);
		}
		
		public function doubleClickHandler(mouseEvent:MouseEvent):void
		{
			_gridModel.zoomTo(mouseEvent.shiftKey ? -_gridModel.maxScale : _gridModel.maxScale);
		}
	}
}