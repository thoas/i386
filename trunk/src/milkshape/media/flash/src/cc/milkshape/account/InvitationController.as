package cc.milkshape.account
{
	import cc.milkshape.account.events.InvitationEvent;
	import cc.milkshape.account.events.InvitationsEvent;
	import cc.milkshape.account.forms.InvitationForm;
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	
	import flash.net.Responder;

	public class InvitationController extends GatewayController
	{
		public function invitations():void
		{
			_responder = new Responder(
				function(result:Object):void
				{
					dispatchEvent(new InvitationsEvent(InvitationsEvent.INVITATIONS_LOADED, result));
				}
			, _onFault);
			Gateway.getInstance().call('account.invitations', _responder);
		}
		
		public function createInvitation():void
		{
			_responder = new Responder(
				function(result:Object):void
				{
					if(result)
					{
						dispatchEvent(new InvitationEvent(InvitationEvent.TICKET_CREATED, null, result.confirmation_key));
					}
				}
			, _onFault);
			Gateway.getInstance().call('account.create_invitation', _responder);
		}
		
		public function sendInvitation(form:InvitationForm):void
		{
			var values:Object = form.values();
			_responder = new Responder(
				function(result:Object):void 
				{
					if(result){
						dispatchEvent(new InvitationEvent(InvitationEvent.SUCCESS, form));
					}
				}
			, _onFault);
			Gateway.getInstance().call('account.send_invitation', _responder, values.ticket, values.email, values.content);
		}
	}
}