package cc.milkshape.issue.events
{
	import flash.events.Event;
	
	public class IssuesEvent extends Event
	{
		public static const LAST_ISSUES_LOADED:String = 'LAST_ISSUES_LOADED';
		private var _lastIssues:Object;
		public function IssuesEvent(type:String, lastIssues:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_lastIssues = lastIssues;
			super(type, bubbles, cancelable);
		}

		public function get lastIssues():Object
		{
			return _lastIssues;
		}

		public function set lastIssues(v:Object):void
		{
			_lastIssues = v;
		}

	}
}