package
{
	import cc.milkshape.grid.GridBackground;
	import cc.milkshape.grid.GridController;
	import cc.milkshape.grid.GridKeyboardController;
	import cc.milkshape.grid.events.GridLineEvent;
	import cc.milkshape.grid.GridModel;
	import cc.milkshape.grid.GridMouseController;
	import cc.milkshape.grid.GridView;
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.grid.square.events.SquareFormEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	[SWF(width='960', height='600', frameRate='31', backgroundColor='#141414')]
	
	public class Issue extends Sprite
	{
		private var _closeHandCursor:ClosedHandCursor;
		private var _openHandCursor:OpenHandCursor;
		private var _bg:Sprite;
		private var _gridModel:GridModel;
		private var _gridController:GridController;
		private var _gridView:GridView;
		private var _debugger:MonsterDebugger;
		
		public function Issue()
		{
			_debugger = new MonsterDebugger(this);
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _handlerRemovedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			stage.stageFocusRect = false;
			//loaderInfo.sharedEvents.addEventListener(PreloaderEvent.INFO, _handlerInit);
			_handlerInit(new PreloaderEvent(PreloaderEvent.INFO, "10x10"));
		}
		
		private function _handlerRemovedToStage(e:Event):void
		{
			
		}
		
		private function _handlerInit(e:PreloaderEvent = null):void
		{
			loaderInfo.sharedEvents.removeEventListener(PreloaderEvent.INFO, _handlerInit);
			
			_debugger = new MonsterDebugger(this);
			_gridModel = new GridModel(e.msg);
			_gridController = new GridController(_gridModel);
			var keyboardController:GridKeyboardController = new GridKeyboardController(_gridModel);
			var mouseController:GridMouseController = new GridMouseController(_gridModel);
			_gridView = new GridView(_gridModel, _gridController, keyboardController, mouseController);
			
			_gridModel.addEventListener(SquareFormEvent.SHOW_OPEN, _showOpenForm);
			_gridModel.addEventListener(SquareFormEvent.SHOW_BOOKED, _showBookedForm);
			_gridModel.addEventListener(SquareFormEvent.CLOSE, _closeForm);		
			
			_bg = new GridBackground();
			_bg.addEventListener(MouseEvent.CLICK, mouseController.stageClickHandler);
			_bg.addEventListener(MouseEvent.DOUBLE_CLICK, mouseController.stageDoubleClickHandler);
			
			addChild(_bg);
			addChild(_gridView);
			
			_closeHandCursor = new ClosedHandCursor();
			_openHandCursor = new OpenHandCursor();
			_closeHandCursor.visible = false;
			_openHandCursor.visible = false;
			addChild(_closeHandCursor);
			addChild(_openHandCursor);
			_gridModel.addEventListener(GridLineEvent.SHOW, _hideOpenHandCursor);
			_gridModel.addEventListener(GridLineEvent.HIDE, _showOpenHandCursor);
		}
		/*
		import flash.events.TimerEvent;
		import flash.utils.Timer;
		private var _showSquareTimer:Timer;
		_showSquareTimer = new Timer(2000, 1);
		_showSquareTimer.stop();
		if(_currentScale == _maxScale)
		{
			var square:Square = _controller.getFocusSquare();
			if(square is SquareOpen)
			{
				_showSquareTimer.removeEventListener('timer', _showSquareBooked);
        		_showSquareTimer.addEventListener('timer', _showSquareOpen);
        		_showSquareTimer.start();
			}
			else if(square is SquareBooked)
			{
				_showSquareTimer.removeEventListener('timer', _showSquareOpen);
        		_showSquareTimer.addEventListener('timer', _showSquareBooked);
        		_showSquareTimer.start();
			}
		}
		*/
		
		private function _mouseMoveHandler(e:MouseEvent = null):void
		{
			_openHandCursor.x = mouseX;
			_openHandCursor.y = mouseY;
			
			_closeHandCursor.x = mouseX;
			_closeHandCursor.y = mouseY;
		}
		
		private function _hideCloseHandCursor(e:MouseEvent):void
		{
			_openHandCursor.visible = true;
			_closeHandCursor.visible = false;
		}
		
		private function _showCloseHandCursor(e:MouseEvent):void
		{
			_openHandCursor.visible = false;
			_closeHandCursor.visible = true;
		}
		
		private function _hideOpenHandCursor(e:GridLineEvent):void
		{
			_openHandCursor.visible = false;
			_closeHandCursor.visible = false;
			removeEventListener(MouseEvent.MOUSE_MOVE, _mouseMoveHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, _showCloseHandCursor);
			removeEventListener(MouseEvent.MOUSE_UP, _hideCloseHandCursor);
			
			_bg.addEventListener(MouseEvent.CLICK, _gridView.mouseController.stageClickHandler);
			_bg.addEventListener(MouseEvent.DOUBLE_CLICK, _gridView.mouseController.stageDoubleClickHandler);
		}
		
		private function _showOpenHandCursor(e:GridLineEvent):void
		{
			_openHandCursor.visible = true;
			_mouseMoveHandler();
			addEventListener(MouseEvent.MOUSE_MOVE, _mouseMoveHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, _showCloseHandCursor);
			addEventListener(MouseEvent.MOUSE_UP, _hideCloseHandCursor);
			
			_bg.removeEventListener(MouseEvent.CLICK, _gridView.mouseController.stageClickHandler);
			_bg.removeEventListener(MouseEvent.DOUBLE_CLICK, _gridView.mouseController.stageDoubleClickHandler);
		}
		
		private function _showOpenForm(e:SquareFormEvent):void
		{
			trace('show open');
		}
		
		private function _showBookedForm(e:SquareFormEvent):void
		{
			trace('show booked');
		}
		
		private function _closeForm(e:SquareFormEvent):void
		{
			trace('close');
		}
	}
}