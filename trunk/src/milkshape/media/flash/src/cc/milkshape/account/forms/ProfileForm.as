package cc.milkshape.account.forms
{
	import cc.milkshape.account.ProfileController;
	import cc.milkshape.account.events.ProfileEvent;
	import cc.milkshape.account.events.ProfilesEvent;
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
		private var _website:LabelInput;
		private var _ownNotif:Checkbox;
		private var _milkshapeNotif:Checkbox;
		private var _update:SmallButton;
		public function ProfileForm(profileController:ProfileController)
		{
			_profileController = profileController;
			_profileController.addEventListener(ProfilesEvent.SUCCESS, _updated);
			_profileController.addEventListener(ProfileEvent.PROFILE, _profile);
			_realname = new LabelInput('NAME:');
			_website = new LabelInput('URL:');
			_location = new LabelInput('LOCATION:');
			_ownNotif = new Checkbox('I want to be advised by e-mail of any activities around my creations');
			_milkshapeNotif = new Checkbox('I want to be advised by e-mail of any activities on #milkshape');
			_update = new SmallButton('UPDATE PROFILE', new UpdateItem());
			
			realname.addChild(_realname);
			url.addChild(_website);
			location.addChild(_location);
			ownNotif.addChild(_ownNotif);
			milkshapeNotif.addChild(_milkshapeNotif);
			update.addChild(_update);
			update.addEventListener(MouseEvent.CLICK, _updateHandler);
			
			_profileController.profile();
		}
		
		private function _updateHandler(e:MouseEvent):void
		{
			_profileController.update(_realname.text, _website.text, _location.text);
		}
		
		private function _profile(e:ProfileEvent):void
		{
			
			if(e.result.name)
				_realname.text = e.result.name;
			if(e.result.website)
				_website.text = e.result.website;
			if(e.result.location)
				_location.text = e.result.location;
		}
		
		public function values():Object
		{
			return {
				'realname': _realname.text,
				'website': _website.text,
				'location': _location.text
			};
		}
		
		public function reset():void
		{
			_realname.blur();
			_website.blur();
			_location.blur();
		}
		
		private function _updated(e:ProfilesEvent):void
		{
			reset();
		}
	}
}