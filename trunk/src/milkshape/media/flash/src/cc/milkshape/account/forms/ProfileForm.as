package cc.milkshape.account.forms
{
	import cc.milkshape.account.ProfileController;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.forms.fields.Checkbox;
	import cc.milkshape.framework.forms.fields.Input;
	public class ProfileForm extends ProfileClp
	{
		private var _profileController:ProfileController;
		private var _realname:Input;
		private var _email:Input;
		private var _url:Input;
		private var _ownNotif:Checkbox;
		private var _milkshapeNotif:Checkbox;
		private var _update:SmallButton;
		public function ProfileForm(profileController:ProfileController)
		{
			_profileController = profileController;
			_realname = new Input('NAME');
			_email = new Input('EMAIL');
			_url = new Input('URL');
			_ownNotif = new Checkbox();
			_milkshapeNotif = new Checkbox();
			_update = new SmallButton('UPDATE INFORMATION', new PlusItem());
			
			realname.addChild(_realname);
			email.addChild(_email);
			url.addChild(_url);
			ownNotif.addChild(_ownNotif);
			milkshapeNotif.addChild(_milkshapeNotif);
			update.addChild(_update);
		}
	}
}