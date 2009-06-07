package cc.milkshape.manager
{
	public class UserManager
	{
		private static var _user:Object;

		public static function getUser():Object
		{
			return _user;
		}

		public static function setUser(v:Object):void
		{
			_user = v;
		}

	}
}