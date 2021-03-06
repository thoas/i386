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
			var decalY:Number = 0;
			var creation:Object;
			
			for each(creation in e.creations.currents)
			{
				creationPreview = new CreationPreview(creation.issue.title, creation.date_booked, '', creation.pos_x, creation.pos_y, creation.issue.slug, true);
				creationPreview.y = decalY;
				currents.addChild(creationPreview);
				creationPreview.addEventListener(CreationPreviewEvent.CANCEL_CLICKED, _cancelHandler);
				decalY = currents.height + 20;
			}
			
			decalY += 80;
			
			archives.y = decalY + 40;
			creationArchivedCount.y = decalY + 8;
			archivesCreationsTitle.y = decalY;
			decalY = 0;
			
			if(e.creations.archives.length > 0)
			{
				creationArchivedCount.text = 'YOU HAVE ' + e.creations.archives.length + ' CREATIONS UPLOADED'; 
				var creationPreview:CreationPreview;
				for each(creation in e.creations.archives)
				{
					creationPreview = new CreationPreview(creation.issue.title, creation.date_finished, '', creation.pos_x, creation.pos_y, creation.issue.slug, false, creation.thumb_url);
					creationPreview.y = decalY;
					archives.addChild(creationPreview);
					decalY = archives.height + 20;
				}
			} else
				creationArchivedCount.text = 'YOU HAVE NO CREATION UPLOADED';
			
			bottomPoint.y = height + 60;
			dispatchEvent(new UpdateViewEvent(UpdateViewEvent.UPDATE));
		}
		
		private function _cancelHandler(e:CreationPreviewEvent):void
		{
			_profileController.release(e.posX, e.posY, e.issueSlug);
		}
		
		private function _creationReleasedHandler(e:CreationsEvent):void
		{
			trace("release");
			currents.removeChildAt(1);
		}
	}
}