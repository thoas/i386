package cc.milkshape.grid
{
	import cc.milkshape.manager.KeyboardManager;

	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class GridKeyboardController
	{
		private var _gridModel:GridModel;
		
		public function GridKeyboardController(gridModel:GridModel)
		{
			_gridModel = gridModel;
		}
			
		public function keyDownHandler(gridEvent:KeyboardEvent):void
		{
			if(KeyboardManager.enabled)
			{
				switch(gridEvent.keyCode)
				{
					case Keyboard.UP:
					case 87: // W
						_gridModel.setFocus(_gridModel.focusY - 1 * (gridEvent.shiftKey ? _gridModel.nbVSquare : 1), _gridModel.focusX);
						break;
	
					case Keyboard.DOWN:
					case 83: // S
						_gridModel.setFocus(_gridModel.focusY + 1 * (gridEvent.shiftKey ? _gridModel.nbVSquare : 1), _gridModel.focusX);
						break;
	
					case Keyboard.LEFT:
					case 65: // A
						_gridModel.setFocus(_gridModel.focusY, _gridModel.focusX - 1 * (gridEvent.shiftKey ? _gridModel.nbHSquare : 1));
						break;
	
					case Keyboard.RIGHT:
					case 68: // D
						_gridModel.setFocus(_gridModel.focusY, _gridModel.focusX + 1 * (gridEvent.shiftKey ? _gridModel.nbHSquare : 1));
						break;
	
					case Keyboard.NUMPAD_ADD:
					case 73: // I
						_gridModel.zoomTo(gridEvent.shiftKey ? _gridModel.maxScale : 1);
						break;
	
					case Keyboard.NUMPAD_SUBTRACT:
					case 79: // O
						_gridModel.zoomTo(gridEvent.shiftKey ? -_gridModel.maxScale : -1);
						break;
						
					case Keyboard.SPACE:
					case 32: // Space bar
						_gridModel.gridLineVisible = false;						
						break;
				}
			}  
		 }
	
		public function keyUpHandler(gridEvent:KeyboardEvent):void
		{
			if(KeyboardManager.enabled)
			{					
				switch(gridEvent.keyCode)
				{
					case Keyboard.SPACE:
					case 32: // Space bar
						_gridModel.gridLineVisible = true;
						break;
				}
			}
		}
	}
}