package cc.milkshape.framework
{
	import flash.events.EventDispatcher;
	import cc.milkshape.user.User;
	public class Controller extends EventDispatcher
	{
		public function getUser():User
		{
			return User.getInstance();
		}
	}
}