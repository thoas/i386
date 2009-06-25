package
{	
	import cc.milkshape.contact.ContactController;
	import cc.milkshape.contact.forms.ContactForm;
	
	import flash.display.MovieClip;

	public class Contact extends MovieClip
	{
		public function Contact()
		{
			var contactController:ContactController = new ContactController();
			var contactView:ContactForm = new ContactForm(contactController);
			addChild(contactView);
		}
	}
}