package
{	
	import cc.milkshape.contact.ContactController;
	import cc.milkshape.contact.forms.ContactForm;
	
	import flash.display.MovieClip;

	public class Contact extends MovieClip
	{
		private var _contactController:ContactController;
		public function Contact()
		{
			_contactController = new ContactController();
			var contactView:ContactForm = new ContactForm(_contactController);
			addChild(contactView);
		}
	}
}