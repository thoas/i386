package cc.milkshape.account
{
	import cc.milkshape.account.events.UpdateViewEvent;
	
	import flash.display.Sprite;
	
	public class Creations extends Sprite
	{
		public function Creations()
		{
			var profileController:ProfileController = new ProfileController();
			var creationView:CreationsView = new CreationsView(profileController);
			addChild(creationView);
			
			creationView.addEventListener(UpdateViewEvent.UPDATE, _update);
		}
		
		private function _update(e:UpdateViewEvent):void
		{
			dispatchEvent(new UpdateViewEvent(UpdateViewEvent.UPDATE));
		}
	}
}