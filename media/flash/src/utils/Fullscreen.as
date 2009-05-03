package utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Fullscreen extends Sprite
	{
		private var _label:TextField;
		
		public function Fullscreen()
		{			
			_label = new TextField();
			_label.selectable = false;

            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFFFFFF;
            format.size = 12;

            _label.defaultTextFormat = format;	
            _label.text = "Fullscreen";
			addChild(_label);
			
			addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
		}
		
		private function _addedToStageHandler(e:Event):void
		{
			addEventListener(MouseEvent.MOUSE_DOWN, _toggleFullScreen);
		}
		
		private function _toggleFullScreen(event:MouseEvent):void {
		    switch(stage.displayState)
		    {
		        case "normal":
		            stage.displayState = "fullScreen";    
		            break;
		        case "fullScreen":
		        default:
		            stage.displayState = "normal";    
		            break;
		    }
		}
		
	}
}