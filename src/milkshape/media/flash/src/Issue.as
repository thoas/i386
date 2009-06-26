package
{
	import cc.milkshape.grid.GridBackground;
	import cc.milkshape.grid.GridController;
	import cc.milkshape.grid.GridKeyboardController;
	import cc.milkshape.grid.GridModel;
	import cc.milkshape.grid.GridMouseController;
	import cc.milkshape.grid.GridNavPanel;
	import cc.milkshape.grid.GridSidebar;
	import cc.milkshape.grid.GridView;
	import cc.milkshape.grid.events.GridLineEvent;
	import cc.milkshape.grid.process.SquareProcess;
	import cc.milkshape.preloader.events.PreloaderEvent;
	
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
		private var _squareProcess:SquareProcess;
		private var _sidebar:GridSidebar;
		private var _navPanel:GridNavPanel;
		
		public function Issue()
		{
			_debugger = new MonsterDebugger(this);
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _handlerRemovedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			stage.stageFocusRect = false;
			loaderInfo.sharedEvents.addEventListener(PreloaderEvent.INFO, _handlerInit);
		}
		
		private function _handlerRemovedToStage(e:Event):void
		{
			
		}
		
		private function _handlerInit(e:PreloaderEvent):void
		{
			loaderInfo.sharedEvents.removeEventListener(PreloaderEvent.INFO, _handlerInit);
			
			_debugger = new MonsterDebugger(this);
			_gridModel = new GridModel(e.option.slug);
			_gridController = new GridController(_gridModel);
			var keyboardController:GridKeyboardController = new GridKeyboardController(_gridModel);
			var mouseController:GridMouseController = new GridMouseController(_gridModel);
			_gridView = new GridView(_gridModel, _gridController, keyboardController, mouseController);
			
			_bg = new GridBackground();
			_bg.addEventListener(MouseEvent.CLICK, mouseController.stageClickHandler);
			_bg.addEventListener(MouseEvent.DOUBLE_CLICK, mouseController.stageDoubleClickHandler);
			
			_squareProcess = new SquareProcess(_gridModel);
			
			addChild(_bg);
			addChild(_gridView);
			addChild(_squareProcess);
			
			_sidebar = new GridSidebar(_gridModel);
			addChild(_sidebar);
			
			_navPanel = new GridNavPanel(_gridModel);
			_navPanel.x = 20;
			addChild(_navPanel);
			
			_closeHandCursor = new ClosedHandCursor();
			_openHandCursor = new OpenHandCursor();
			_closeHandCursor.visible = false;
			_openHandCursor.visible = false;
			addChild(_closeHandCursor);
			addChild(_openHandCursor);
			_gridModel.addEventListener(GridLineEvent.SHOW, _hideOpenHandCursor);
			_gridModel.addEventListener(GridLineEvent.HIDE, _showOpenHandCursor);
			
			stage.addEventListener(Event.RESIZE, _handlerResize);
			_handlerResize(null);
		}
		
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
		
		private function _handlerResize(e:Event):void
		{
			trace('un');
			_squareProcess.x =  Math.round(stage.stageWidth * 0.5) - 400;
			_squareProcess.y =  Math.round(stage.stageHeight * 0.5) - 400;
			_sidebar.x = stage.stageWidth - 136;
			_navPanel.y = Math.round(stage.stageHeight * 0.5) - 96;
		}
	}
}