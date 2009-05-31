package grid
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class MemoryIndicator extends Sprite
	{
		public var _label:TextField;
		
		public function MemoryIndicator()
		{
			_label = new TextField();
			_label.selectable = false;

            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFFFFFF;
            format.size = 12;

            _label.defaultTextFormat = format;			
			addChild(_label);
			
			addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
		}
		
		private function _addedToStageHandler(e:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, _enterFrameHandler);
		}
		
		private function _enterFrameHandler(e:Event):void
		{
			_label.text = (System.totalMemory / 1024 / 1024).toFixed(2) + "MB";
		}
		
	}
}