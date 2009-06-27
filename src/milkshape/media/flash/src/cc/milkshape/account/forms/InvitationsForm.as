package cc.milkshape.account.forms
{
	import cc.milkshape.account.InvitationController;
	import cc.milkshape.framework.forms.fields.LabelInput;
	import cc.milkshape.framework.forms.fields.LabelTextarea;

	public class InvitationsForm extends InvitationFormClp
	{
		private var _invitationController:InvitationController;
		private var _email:LabelInput;
		private var _content:LabelTextarea;
		public function InvitationsForm(invitationController:InvitationController, ticketKey:String)
		{
			_invitationController = invitationController;
			ticket.text = ticketKey;
			
			_email = new LabelInput('SEND TO:');
			_content = new LabelTextarea('CONTENT:');
			
			email.addChild(_email);
			content.addChild(_content);
		}
	}
}