package cc.milkshape.account.forms
{
	import cc.milkshape.account.ProfileController;
	import cc.milkshape.account.events.ProfileEvent;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.framework.forms.fields.Checkbox;
	import cc.milkshape.framework.forms.fields.LabelInput;
	
	import flash.events.MouseEvent;

	public class ProfileForm extends ProfileClp implements Formable
	{
		private var _profileController:ProfileController;
		private var _realname:LabelInput;
		private var _location:LabelInput;
		private var _url:LabelInput;
		private var _ownNotif:Checkbox;
		private var _milkshapeNotif:Checkbox;
		private var _update:SmallButton;
		public function ProfileForm(profileController:ProfileController)
		{
			_profileController = profileController;
			_realname = new LabelInput('NAME:');
			_url = new LabelInput('URL:');
			_location = new LabelInput('LOCATION:');
			_ownNotif = new Checkbox();
			_milkshapeNotif = new Checkbox();
			_update = new SmallButton('UPDATE INFORMATION', new PlusItem());
			
			realname.addChild(_realname);
			url.addChild(_url);
			location.addChild(_location);
			ownNotif.addChild(_ownNotif);
			milkshapeNotif.addChild(_milkshapeNotif);
			update.addEventListener(MouseEvent.CLICK, _updateHandler);
			_profileController.addEventListener(ProfileEvent.SUCCESS, _updated);
		}
		
		private function _updateHandler(e:MouseEvent):void
		{
			_profileController.update(_realname.text, _url.text, _location.text);
		}
		
		public function values():Object
		{
			return {
				'realname': _realname.text,
				'url': _url.text,
				'location': _location.text
			};
		}
		
		public function reset():void
		{
			_realname.blur();
			_url.blur();
			_location.blur();
		}
		
		private function _updated(e:ProfileEvent):void
		{
			reset();
		}
	}
}