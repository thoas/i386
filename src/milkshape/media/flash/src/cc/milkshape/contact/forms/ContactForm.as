package cc.milkshape.contact.forms
{
	import cc.milkshape.user.forms.Input;
	import cc.milkshape.user.forms.Textarea;
	import cc.milkshape.utils.buttons.SmallButton;
	
	import flash.events.MouseEvent;
	import cc.milkshape.contact.ContactController;
	
	public class ContactForm extends ContactClp
	{
		private var _author:Input;
		private var _email:Input;
		private var _subject:Input;
		private var _content:Textarea;
		private var _submit:SmallButton;
		private var _contactController:ContactController;
		public function ContactForm(contactController:ContactController)
		{
			_contactController = contactController;
			_author = new Input('Name');
			_email = new Input('Email');
			_subject = new Input('Subject');
			_content = new Textarea('Message');
			_submit = new SmallButton('SEND', new PlusItem());
			_submit.addEventListener(MouseEvent.CLICK, _contact);
			
			author.addChild(_author);
			email.addChild(_email);
			subject.addChild(_subject);
			content.addChild(_content);
			submit.addChild(_submit);
		}
		
		private function _contact(e:MouseEvent):void {
			_contactController.contact(_author.text, _email.text, _subject.text, _content.text);
		}
	}
}