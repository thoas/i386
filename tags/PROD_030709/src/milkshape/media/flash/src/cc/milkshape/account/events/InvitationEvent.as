package cc.milkshape.account.events
{
	import cc.milkshape.account.forms.InvitationForm;
	
	import flash.events.Event;

	public class InvitationEvent extends Event
	{
		public static const SUCCESS:String = 'SUCCESS';
		public static const TICKET_CREATED:String = 'TICKET_CREATED';
		private var _invitationForm:InvitationForm;
		private var _ticket:String;
		public function InvitationEvent(type:String, invitationForm:InvitationForm=null, ticket:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_invitationForm = invitationForm;
			_ticket = ticket;
			super(type, bubbles, cancelable);
		}

		public function get ticket():String
		{
			return _ticket;
		}

		public function set ticket(v:String):void
		{
			_ticket = v;
		}

		public function get invitationForm():InvitationForm
		{
			return _invitationForm;
		}

		public function set invitationForm(v:InvitationForm):void
		{
			_invitationForm = v;
		}

	}
}