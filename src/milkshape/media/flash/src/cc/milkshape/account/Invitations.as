package cc.milkshape.account
{
	import cc.milkshape.account.events.InvitationsEvent;
	import cc.milkshape.account.forms.InvitationsForm;
	import cc.milkshape.framework.buttons.SmallButton;
	
	import flash.events.MouseEvent;

	public class Invitations extends InvitationsClp
	{
		private var _invitationController:InvitationController;
		private var _createInvitation:SmallButton;
		private var _sendInvitations:SmallButton;
		public function Invitations()
		{
			_invitationController = new InvitationController();	
			_invitationController.addEventListener(InvitationsEvent.INVITATIONS_LOADED, _invitationsHandler);
			_invitationController.invitations();
			
			_createInvitation = new SmallButton('INVITE A FRIEND', new PlusItem());
			_createInvitation.addEventListener(MouseEvent.CLICK, _createInvitationHandler);
			createInvitation.addChild(_createInvitation);
			
			_sendInvitations = new SmallButton('SEND', new UpdateItem());
		}
		
		private function _createInvitationHandler(e:MouseEvent):void
		{
			var form:InvitationsForm = new InvitationsForm(_invitationController, 'sdfsdf4sdf54ds5f45sdf4');
			formContainer.addChild(form);
			if(!sendInvitations.contains(_sendInvitations))
				sendInvitations.addChild(_sendInvitations);
			sendInvitations.y = formContainer.y + formContainer.height + 15;
		}
		
		private function _invitationsHandler(e:InvitationsEvent):void
		{
			invitationsLeft.text = 'You have ' + e.invitations.remain_invitation + ' invitations left';
		}
	}
}