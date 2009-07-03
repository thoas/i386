package cc.milkshape.framework.mvc
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