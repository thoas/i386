package cc.milkshape.grid
{
	import cc.milkshape.grid.events.GridZoomEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class GridNavPanel extends NavigationPanelClp
	{
		private var _gridModel:GridModel;
		private var _lastScale:MovieClip;
		
		public function GridNavPanel(gridModel:GridModel)
		{
			_gridModel = gridModel;
			
			_lastScale = scale4Btn as MovieClip;
			
			zoomPlusBtn.buttonMode = true;
			zoomMoinsBtn.buttonMode = true;
			moveUpBtn.buttonMode = true;
			moveRightBtn.buttonMode = true;
			moveDownBtn.buttonMode = true;
			moveLeftBtn.buttonMode = true;
			scale1Btn.buttonMode = true;
			scale2Btn.buttonMode = true;
			scale3Btn.buttonMode = true;
			scale4Btn.buttonMode = true;
			
			scale1Btn.addEventListener(MouseEvent.CLICK, _zoomHandler);
			scale2Btn.addEventListener(MouseEvent.CLICK, _zoomHandler);
			scale3Btn.addEventListener(MouseEvent.CLICK, _zoomHandler);
			scale4Btn.addEventListener(MouseEvent.CLICK, _zoomHandler);
			zoomPlusBtn.addEventListener(MouseEvent.CLICK, _zoomHandler);
			zoomMoinsBtn.addEventListener(MouseEvent.CLICK, _zoomHandler);
			moveUpBtn.addEventListener(MouseEvent.CLICK, _moveHandler);
			moveRightBtn.addEventListener(MouseEvent.CLICK, _moveHandler);
			moveDownBtn.addEventListener(MouseEvent.CLICK, _moveHandler);
			moveLeftBtn.addEventListener(MouseEvent.CLICK, _moveHandler);
			
			_gridModel.addEventListener(GridZoomEvent.ZOOM, _putScale);			
		}
		
		private function _putScale(e:GridZoomEvent):void
		{
			_lastScale.gotoAndStop('off');
			
			if(e.currentScale == _gridModel.maxScale)
			{
				_lastScale = scale4Btn as MovieClip;
			}
			else if(e.currentScale == _gridModel.minScale)
			{
				_lastScale = scale1Btn as MovieClip;
			}
			else if(e.currentScale == Math.ceil(_gridModel.maxScale - _gridModel.minScale - 1 / 2))
			{
				_lastScale = scale2Btn;
			}
			else
			{
				_lastScale = scale3Btn;
			}
			
			_lastScale.gotoAndStop('on');
		}
		
		private function _zoomHandler(e:MouseEvent):void
		{
			var op:int;
			switch(e.target.name)
			{
				case 'zoomPlusBtn':
					_gridModel.zoomTo(1);
					break;

				case 'zoomMoinsBtn':
					_gridModel.zoomTo(-1);
					break;
					
				case 'scale4Btn':
					_gridModel.zoomToScale(_gridModel.maxScale);
					break;
					
				case 'scale3Btn':
					_gridModel.zoomToScale(_gridModel.minScale + Math.ceil((_gridModel.maxScale - _gridModel.minScale + 1) / 2));
					break;
					
				case 'scale2Btn':
					_gridModel.zoomToScale(_gridModel.minScale + Math.ceil((_gridModel.maxScale - _gridModel.minScale - 1) / 2));
					break;

				case 'scale1Btn':
					_gridModel.zoomToScale(_gridModel.minScale)
					break;				
			}
		}
		
		private function _moveHandler(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case 'moveUpBtn':
					_gridModel.setFocus(_gridModel.focusY - 1, _gridModel.focusX);
					break;

				case 'moveDownBtn':
					_gridModel.setFocus(_gridModel.focusY + 1, _gridModel.focusX);
					break;

				case 'moveLeftBtn':
					_gridModel.setFocus(_gridModel.focusY, _gridModel.focusX - 1);
					break;

				case 'moveRightBtn':
					_gridModel.setFocus(_gridModel.focusY, _gridModel.focusX + 1);
					break;
			}
		}
	}
}