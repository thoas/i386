package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Concept extends MovieClip
	{		
		public function Concept()
		{
			addEventListener(Event.ADDED_TO_STAGE, _addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, _removedFromStageHandler);
		}
		
		private function _removedFromStageHandler(e:Event):void
		{
		}
		
		private function _addedToStageHandler(e:Event):void
		{
			
        }		
		
	}
	
}