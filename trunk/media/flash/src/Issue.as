package
{
	import com.dosites.debug.FBConsole;
	import com.dosites.debug.FPSMeter;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import grid.GridController;
	import grid.GridModel;
	import grid.GridView;
	import grid.square.SquareFormEvent;
	
	import utils.Fullscreen;
	import utils.MemoryIndicator;
	import utils.MilkshapeContextMenu;
	import utils.MilkshapeLogo;

	[SWF(width='960', height='600', frameRate='31', backgroundColor='#141414')]// 31 plus efficace
	
	public class Issue extends Sprite
	{
		private var _memoryIndicator:MemoryIndicator;
		private var _milkshapeLogo:MilkshapeLogo;
		private var _fullscreen:Fullscreen;
		
		public function Issue(issueId:int = 0)
		{
			//new FBConsole();
			//new FPSMeter(stage);
			
			stage.align = StageAlign.TOP_LEFT;
        	stage.scaleMode = StageScaleMode.NO_SCALE;
        	stage.stageFocusRect = false;
        	
			var mct:MilkshapeContextMenu = new MilkshapeContextMenu();// Menu contextuel personnalisé
			contextMenu = mct.cm;
			
			var gridModel:GridModel = new GridModel(issueId);
			var gridController:GridController = new GridController(gridModel);
			var gridView:GridView = new GridView(gridModel, gridController);
			
			_memoryIndicator = new MemoryIndicator();
			_milkshapeLogo = new MilkshapeLogo();
			_fullscreen = new Fullscreen();
			
			stage.addEventListener(Event.RESIZE, _resize);
			gridModel.addEventListener(SquareFormEvent.SHOW_OPEN, _showOpenForm);
			gridModel.addEventListener(SquareFormEvent.SHOW_BOOKED, _showBookedForm);
			gridModel.addEventListener(SquareFormEvent.CLOSE, _closeForm);

			addChild(gridView);
			addChild(_memoryIndicator);
			addChild(_milkshapeLogo);
			addChild(_fullscreen);
			
			_resize();
		}
		
		private function _resize(e:Event = null):void
		{
			_fullscreen.x = stage.stageWidth - 70;
			_fullscreen.y = 0;
			
			_memoryIndicator.x = stage.stageWidth - 60;
			_memoryIndicator.y = stage.stageHeight - 20;
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