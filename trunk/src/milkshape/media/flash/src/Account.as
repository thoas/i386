package
{
	import cc.milkshape.account.AccountView;
	
	import flash.display.MovieClip;
	
	public class Account extends MovieClip
	{
		public function Account()
		{
			var menu:Array = new Array(
				{label: 'creations', slug: 'creations'},
				{label: 'invitations', slug: 'invitations'},
				{label: 'profil', slug: 'profil'}
			)
			addChild(new AccountView(menu));
		}
	}
	
}