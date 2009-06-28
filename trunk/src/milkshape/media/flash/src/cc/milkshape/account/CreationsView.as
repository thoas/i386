package cc.milkshape.account
{
	import cc.milkshape.account.events.CreationsEvent;
	public class CreationsView extends CreationsClp
	{
		private var _profileController:ProfileController;
		public function CreationsView(profileController:ProfileController)
		{
			_profileController = profileController;
			_profileController.addEventListener(CreationsEvent.CREATIONS_LOADED, _creationsLoadedHandler);
			_profileController.creations();
		}
		
		private function _creationsLoadedHandler(e:CreationsEvent):void
		{
			var height:Number;
			var creation:Object;
			if(e.creations.archives.length > 0)
			{
				invitationsLeft.text = 'YOU HAVE ' + e.creations.archives.length + ' CREATIONS UPLOADED'; 
				var creationPreview:CreationPreview;
				height = 0;
				for each(creation in e.creations.archives)
				{
					creationPreview = new CreationPreview(creation.issue.title, creation.date_finished, '', creation.pos_y, creation.pos_x, creation.issue.slug, creation.thumb_url);
					creationPreview.y = height;
					archives.addChild(creationPreview);
					height = archives.height + 20;
				}
			} else
				invitationsLeft.text = 'YOU HAVE NO CREATION UPLOADED';
			
			height = 0;
			for each(creation in e.creations.currents)
			{
				creationPreview = new CreationPreview(creation.issue.title, creation.date_booked, '', creation.pos_y, creation.pos_x, creation.issue.slug);
				creationPreview.y = height;
				currents.addChild(creationPreview);
				height = currents.height + 20;
			}
		}
	}
}