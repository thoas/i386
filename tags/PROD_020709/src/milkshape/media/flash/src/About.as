package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class About extends MovieClip
	{		
		public function About()
		{
			addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, _removedFromStageHandler);
		}
		
		private function _removedFromStageHandler(e:Event):void
		{
		}
		
		private function _addedToStageHandler(e:Event):void
		{
			addChild(new AboutClp());
        }		
		
	}
	
}