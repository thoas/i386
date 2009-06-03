package
{
	import cc.milkshape.utils.MilkshapeTextFormat;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	[SWF(width='960', height='600', frameRate='31', backgroundColor='#141414')]
	
	public class About extends MovieClip
	{
		private var _label:TextField;
		
		public function About()
		{
			addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, _removedFromStageHandler);
		}
		
		private function _removedFromStageHandler(e:Event):void
		{
			//removeEventListener(Event.REMOVED_FROM_STAGE, _removedFromStageHandler);	
		}
		
		private function _addedToStageHandler(e:Event):void
		{
			//removeEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);

            _label = new TextField();
            _label.defaultTextFormat = MilkshapeTextFormat.H1();
            _label.width = 400;
            _label.height = 300;
            _label.multiline = true;
			_label.selectable = false;            
            _label.embedFonts = true;
            _label.text = "Hey bienvenue sur about";
			addChild(_label);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, _resizeHandler);
			_resizeHandler(null);			
		}
		
		private function _resizeHandler(e:Event):void
		{
			_label.x = Math.round(stage.stageWidth / 2 - _label.width / 2);
			_label.y = Math.round(stage.stageHeight / 2 - _label.height / 2);
        }		
		
	}
	
}