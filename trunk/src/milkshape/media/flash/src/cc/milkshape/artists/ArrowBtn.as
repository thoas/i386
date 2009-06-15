package cc.milkshape.artists
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ArrowBtn extends ArrowBtnClp
	{
		public function ArrowBtn()
		{
			buttonMode = true;
			stop();
			
			addEventListener(MouseEvent.ROLL_OVER, _overHandler);
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}

		private function _enterFrame(e:Event):void
		{
			nextFrame();
			
			if(currentLabel == 'end')
				gotoAndStop('start');

			if (currentLabel == 'start')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}

	}
}