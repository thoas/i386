package
{
	import cc.milkshape.home.Header;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Home extends MovieClip
	{
		private var _checkerboard:Sprite;
		private var _header:Header;
		private var _mask:Sprite;
		
		public function Home()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			stage.addEventListener(Event.RESIZE, _handlerResize);
			_header = new Header();
			_header.y = 60;
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, 10, 10);
			_header.mask = _mask;
				
			_checkerboard = new Sprite();
			_checkerboard.graphics.beginBitmapFill(new CheckerboardBm(2, 2));
            _checkerboard.graphics.drawRect(0, 0, 200, 90);
            _checkerboard.graphics.endFill();
            _checkerboard.y = 90;
            _checkerboard.x = stage.stageWidth - 250;
            
			addChild(_header);
			addChild(_checkerboard);
			
			_handlerResize(null);			
		}
		
		private function _handlerResize(e:Event):void
		{
			trace('ok');
			_mask.width = stage.stageWidth;
			_mask.height = Math.round(stage.stageHeight/2);
		}
	}
	
}