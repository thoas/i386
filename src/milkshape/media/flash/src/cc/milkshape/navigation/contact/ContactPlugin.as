package cc.milkshape.navigation.contact
{
	import cc.milkshape.navigation.contact.view.ContactFormUI;
	import cc.milkshape.navigation.generic.UIList;
	
	import com.bourre.plugin.AbstractPlugin;
	
	import flash.display.MovieClip;

	public class ContactPlugin extends AbstractPlugin
	{
		private var _container:MovieClip;
		public function ContactPlugin(container:MovieClip)
		{
			_container = container;
			var contactFormUI:ContactFormUI = new ContactFormUI(this, UIList.CONTACT, container);
		}
	}
}