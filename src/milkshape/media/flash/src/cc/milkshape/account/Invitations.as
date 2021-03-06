package cc.milkshape.account
{
	import cc.milkshape.account.events.InvitationEvent;
	import cc.milkshape.account.events.InvitationsEvent;
	import cc.milkshape.account.forms.InvitationForm;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.account.events.UpdateViewEvent;
	
	import flash.events.MouseEvent;

	public class Invitations extends InvitationsClp
	{
		private var _invitationController:InvitationController;
		private var _invitationForms:Array;
		private var _createInvitation:SmallButton;
		private var _sendInvitations:SmallButton;
		private var _remainInvitation:int;
		
		public function Invitations()
		{
			_invitationController = new InvitationController();	
			_invitationController.addEventListener(InvitationsEvent.INVITATIONS_LOADED, _invitationsHandler);
			_invitationController.addEventListener(InvitationEvent.SUCCESS, _invitationSent);
			_invitationController.addEventListener(InvitationEvent.TICKET_CREATED, _ticketCreated);
			_invitationController.invitations();
			
			_createInvitation = new SmallButton('INVITE A FRIEND', new PlusItem());
			_createInvitation.addEventListener(MouseEvent.CLICK, _createInvitationHandler);
			createInvitation.addChild(_createInvitation);
			
			_sendInvitations = new SmallButton('SEND', new UpdateItem());
			_sendInvitations.addEventListener(MouseEvent.CLICK, _sendInvitationsHandler);
			
			_invitationForms = new Array();
		}
		
		private function _invitationSent(e:InvitationEvent):void
		{
			var form:InvitationForm = e.invitationForm;
			_invitationForms = _invitationForms.splice(_invitationForms.indexOf(form), 1);
			formContainer.removeChild(form);
			_invitationController.invitations();
		}
		
		private function _ticketCreated(e:InvitationEvent):void
		{
			_remainInvitation--;
			_createInvitationForm(e.ticket);
			_initPositions();
			dispatchEvent(new UpdateViewEvent(UpdateViewEvent.UPDATE));
		}
		
		private function _createInvitationForm(ticket:String):void
		{
			var form:InvitationForm = new InvitationForm(_invitationController, ticket);
			_invitationForms.push(form);
			formContainer.addChild(form);
		}
		
		private function _createInvitationHandler(e:MouseEvent):void
		{
			if(_remainInvitation > 0)
				_invitationController.createInvitation();
		}
		
		private function _initPositions():void
		{
			var decalY:Number = 10;
			for each(var form:InvitationForm in _invitationForms)
			{
				form.y = decalY + 10;
				decalY += form.y + form.height; 	
			}
			if(_invitationForms.length > 0)
				if(!sendInvitations.contains(_sendInvitations))
					sendInvitations.addChild(_sendInvitations);
			else
				if(sendInvitations.contains(_sendInvitations))
					sendInvitations.removeChild(_sendInvitations);
			
			sendInvitations.y = formContainer.y + formContainer.height + 15;
			mailArea.y = sendInvitations.y + sendInvitations.height + 15;
			
			invitationsLeft.text = 'You have ' + _remainInvitation + ' invitations left';
			
			bottomPoint.y = height + 60;
		}
		
		private function _sendInvitationsHandler(e:MouseEvent):void
		{
			for each(var form:InvitationForm in _invitationForms)
			{
				_invitationController.sendInvitation(form);
			}
		}
		
		private function _invitationsHandler(e:InvitationsEvent):void
		{
			_remainInvitation = e.invitations.remain_invitation;
			for each(var unusedInvitation:Object in e.invitations.unused_invitations)
			{
				_createInvitationForm(unusedInvitation.confirmation_key);
			}
			
			mailArea.emailSendInvitations.htmlText = '';
			for each(var sentInvitation:Object in e.invitations.sent_invitations)
			{
				mailArea.emailSendInvitations.htmlText += sentInvitation.email + '<br />';
			}
			
			mailArea.emailGuestSigned.htmlText = '';
			for each(var userInvited:Object in e.invitations.users_invited)
			{
				mailArea.emailGuestSigned.htmlText += userInvited.email + '<br />';
			}
			
			_initPositions();
		}
	}
}