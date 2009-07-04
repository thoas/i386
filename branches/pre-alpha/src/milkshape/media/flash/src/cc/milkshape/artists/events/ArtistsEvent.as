package cc.milkshape.artists.events
{
	import flash.events.Event;
	
	public class ArtistsEvent extends Event
	{
		public static const SQUARES_BY_ISSUES_LOADED:String = 'SQUARES_BY_ISSUES_LOADED';
		private var _issues:Array;
		public function ArtistsEvent(type:String, issues:Array, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_issues = issues;
			super(type, bubbles, cancelable);
		}

		public function get issues():Array
		{
			return _issues;
		}

		public function set issues(v:Array):void
		{
			_issues = v;
		}

	}
}