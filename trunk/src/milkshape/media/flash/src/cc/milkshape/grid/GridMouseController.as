package cc.milkshape.grid
{
	import cc.milkshape.grid.square.SquareEvent;
	
	import flash.events.MouseEvent;
	import cc.milkshape.grid.GridModel;
	import cc.milkshape.manager.KeyboardManager;
	
	public class GridMouseController
	{
		private var _gridModel:GridModel;
		private var _pointClickX:int;
		private var _pointClickY:int;
		private var _overX:int;
		private var _overY:int;
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
			_overX = e.square.X;
			_overY = e.square.Y;
			_clickEnabled = (_gridModel.focusX == _overX && _gridModel.focusY == _overY) ? true : false;
		}
		
		
		public function mouseWheelHandler(e:MouseEvent):void
		{
			_gridModel.setFocus(_overX, _overY);
			_gridModel.zoomTo(Math.round(e.delta/4));
		}
		
		public function clickHandler(e:MouseEvent):void
		{
			KeyboardManager.enabled = true;
			if(_clickEnabled || _gridModel.currentScale == _gridModel.minScale)
			{
				_gridModel.zoomTo(e.shiftKey ? -1 : 1);
			}
			_clickEnabled = (_gridModel.focusX == _overX && _gridModel.focusY == _overY) ? true : false;
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