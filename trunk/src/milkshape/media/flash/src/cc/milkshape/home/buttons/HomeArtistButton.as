package cc.milkshape.home
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	public class HomeArtistButton extends HomeArtistClp
	{
		private var _overStatut:Boolean;
		
		public function HomeArtistButton(o:Object, pair:Boolean = true)
		{
			buttonMode = true;
			stop();
			_overStatut = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			
			artistText.label.autoSize = TextFieldAutoSize.LEFT;
			artistText2.label.autoSize = TextFieldAutoSize.LEFT;
			if(pair)
			{
				artistText.label.text = o.name;
				artistText2.label.text = '';
				over.width = artistText.width;
			}
			else
			{
				artistText2.label.text = o.name;
				artistText.label.text = '';
				over.width = artistText2.width;
			}			
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			_overStatut = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			_overStatut = false;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _enterFrame(e:Event):void
		{
			if (_overStatut)
				nextFrame();
			else
				prevFrame();

			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			trace('go to ');
		}
	}
}