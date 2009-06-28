package cc.milkshape.account.forms
{
	import cc.milkshape.account.InvitationController;
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.framework.forms.fields.LabelInput;
	import cc.milkshape.framework.forms.fields.LabelTextarea;

	public class InvitationForm extends InvitationFormClp implements Formable
	{
		private var _invitationController:InvitationController;
		private var _email:LabelInput;
		private var _content:LabelTextarea;
		public function InvitationForm(invitationController:InvitationController, ticketKey:String)
		{
			_invitationController = invitationController;
			ticket.text = ticketKey;
			
			_email = new LabelInput('SEND TO:');
			_content = new LabelTextarea('CONTENT:');
			
			email.addChild(_email);
			content.addChild(_content);
		}
		
		public function values():Object
		{
			return {
				'email': _email.text,
				'ticket': ticket.text,
				'content': _content.text
			};
		}
		
		public function reset():void
		{
			_email.blur();
			_content.blur();
		}
	}
}