package cc.milkshape.navigation.about.view
{
	import cc.milkshape.framework.forms.FormUI;
	import cc.milkshape.framework.forms.widgets.*;
	
	import com.bourre.plugin.Plugin;
	
	import flash.display.DisplayObject;
	public class ContactFormUI extends FormUI
	{
		public function ContactFormUI(owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
		}
		
		override public function configure():void
		{
			setWidgets({
				author: new WidgetFormInput(getOwner(), 'Name'),
				email: new WidgetFormInput(getOwner(), 'Email'),
				subject: new WidgetFormInput(getOwner(), 'Subject'),
				content: new WidgetFormTextarea(getOwner(), 'Message'),
				submit: new WidgetFormSmallButton(getOwner(), 'SEND', new PlusItem())
			});
		}
	}
}