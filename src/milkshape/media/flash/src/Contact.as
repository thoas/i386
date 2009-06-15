package
{
	import cc.milkshape.user.forms.Input;
	import cc.milkshape.user.forms.Textarea;
	import cc.milkshape.utils.BigButton;
	import cc.milkshape.utils.SmallButton;
	
	import flash.display.MovieClip;

	public class Contact extends MovieClip
	{
		private var _author:Input;
		private var _email:Input;
		private var _subject:Input;
		private var _content:Textarea;
		private var _submit:SmallButton;
		
		public function Contact()
		{
			_author = new Input('Name');
			_email = new Input('Email');
			_subject = new Input('Subject');
			_content = new Textarea('Message');
			_submit = new SmallButton('SEND', new PlusItem());
			
			var contactClp:ContactClp = new ContactClp();
			contactClp.author.addChild(_author);
			contactClp.email.addChild(_email);
			contactClp.subject.addChild(_subject);
			contactClp.content.addChild(_content);
			contactClp.submit.addChild(_submit);
			
			addChild(contactClp);
		}
	}
}