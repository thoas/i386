package
{
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import grid.GridController;
	import grid.GridModel;
	import grid.GridView;
	import grid.GridEvent;
	
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
			stage.align = StageAlign.TOP_LEFT;
        	stage.scaleMode = StageScaleMode.NO_SCALE;
        	
			var mct:MilkshapeContextMenu = new MilkshapeContextMenu();// Menu contextuel personnalisé
			contextMenu = mct.cm;
			
			var gridModel:GridModel = new GridModel(issueId);
			var gridController:GridController = new GridController(gridModel);
			var gridView:GridView = new GridView(gridModel, gridController, this.stage);
			addChild(gridView);
			
			_memoryIndicator = new MemoryIndicator();
			_milkshapeLogo = new MilkshapeLogo();
			_fullscreen = new Fullscreen();
			addChild(_memoryIndicator);
			addChild(_milkshapeLogo);
			addChild(_fullscreen);
			
			stage.addEventListener(Event.RESIZE, _resize);
			_resize();
			
			gridView.addEventListener(GridEvent.GRID_OPEN_SQUARE, _showSquareOpen);
			gridView.addEventListener(GridEvent.GRID_BOOKED_SQUARE, _showSquareBooked);
		}
		
		private function _resize(e:Event = null):void
		{
			_fullscreen.x = stage.stageWidth - 70;
			_fullscreen.y = 0;
			
			_memoryIndicator.x = stage.stageWidth - 60;
			_memoryIndicator.y = stage.stageHeight - 20;
		}
		
		private function _showSquareOpen(e:GridEvent):void
		{
			trace('SquareOpen');
		}
		
		private function _showSquareBooked(e:GridEvent):void
		{
			trace('SquareBooked');
		}
	}
}