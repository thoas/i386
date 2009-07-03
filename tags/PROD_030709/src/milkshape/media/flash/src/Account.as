package
{
	import cc.milkshape.account.AccountView;
	import cc.milkshape.account.Creations;
	import cc.milkshape.account.Invitations;
	import cc.milkshape.account.Profile;
	import cc.milkshape.account.Password;
	
	import flash.display.MovieClip;

	public class Account extends MovieClip
	{
		public function Account()
		{
			var menu:Array = new Array(
				{label: 'creations', slug: 'creations', view: new Creations() },
				{label: 'invitations', slug: 'invitations', view: new Invitations() },
				{label: 'profile', slug: 'profile', view: new Profile() },
				{label: 'password', slug: 'password', view: new Password() }
			)
			addChild(new AccountView(menu));
		}
	}
	
}