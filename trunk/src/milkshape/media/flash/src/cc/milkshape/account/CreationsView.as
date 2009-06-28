package cc.milkshape.account
{
	import cc.milkshape.account.events.CreationPreviewEvent;
	import cc.milkshape.account.events.CreationsEvent;
	import cc.milkshape.account.events.UpdateViewEvent;

	public class CreationsView extends CreationsClp
	{
		private var _profileController:ProfileController;
		
		public function CreationsView(profileController:ProfileController)
		{
			_profileController = profileController;
			_profileController.addEventListener(CreationsEvent.CREATIONS_LOADED, _creationsLoadedHandler);
			_profileController.addEventListener(CreationsEvent.CREATION_RELEASED, _creationReleasedHandler);
			_profileController.creations();
		}
		
		private function _creationsLoadedHandler(e:CreationsEvent):void
		{
			var decalY:Number;
			var creation:Object;
			if(e.creations.archives.length > 0)
			{
				creationArchivedCount.text = 'YOU HAVE ' + e.creations.archives.length + ' CREATIONS UPLOADED'; 
				var creationPreview:CreationPreview;
				decalY = 0;
				for each(creation in e.creations.archives)
				{
					creationPreview = new CreationPreview(creation.issue.title, creation.date_finished, '', creation.pos_x, creation.pos_y, creation.issue.slug, false, creation.thumb_url);
					creationPreview.y = decalY;
					archives.addChild(creationPreview);
					decalY = archives.height + 20;
				}
			} else
				creationArchivedCount.text = 'YOU HAVE NO CREATION UPLOADED';
			
			decalY = 0;
			for each(creation in e.creations.currents)
			{
				creationPreview = new CreationPreview(creation.issue.title, creation.date_booked, '', creation.pos_x, creation.pos_y, creation.issue.slug, true);
				creationPreview.y = decalY;
				currents.addChild(creationPreview);
				creationPreview.addEventListener(CreationPreviewEvent.CANCEL_CLICKED, _cancelHandler);
				decalY = currents.height + 20;
			}
			
			bottomPoint.y = height + 60;
			dispatchEvent(new UpdateViewEvent(UpdateViewEvent.UPDATE));
		}
		
		private function _cancelHandler(e:CreationPreviewEvent):void
		{
			_profileController.release(e.posY, e.posX, e.issueSlug);
		}
		
		private function _creationReleasedHandler(e:CreationsEvent):void
		{
			trace("release");
			// en dur pour l'instant
			currents.removeChildAt(2);
		}
	}
}