package cc.milkshape.grid
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GridSidebar extends SidebarClp
	{
		private var _nextFrame:Boolean;
		
		public function GridSidebar()
		{
			stop();
			super();
			_nextFrame = false;
			
			open.buttonMode = true;
			open.addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			_nextFrame = !_nextFrame;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}

		private function _enterFrame(e:Event):void
		{
			if(_nextFrame)
				nextFrame();
			else
				prevFrame();

			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
	}
}