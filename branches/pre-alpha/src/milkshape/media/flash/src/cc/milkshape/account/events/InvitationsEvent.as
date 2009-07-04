package cc.milkshape.account.events
{
	import flash.events.Event;
	
	public class InvitationsEvent extends Event
	{
		public static const INVITATIONS_LOADED:String = 'INVITATIONS_LOADED';
		private var _invitations:Object;
		public function InvitationsEvent(type:String, invitations:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_invitations = invitations;
			super(type, bubbles, cancelable);
		}

		public function get invitations():Object
		{
			return _invitations;
		}

		public function set invitations(v:Object):void
		{
			_invitations = v;
		}

	}
}