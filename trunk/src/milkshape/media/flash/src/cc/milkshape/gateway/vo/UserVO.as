package cc.milkshape.gateway.vo
{
    [RemoteClass(alias="django.contrib.auth.models.User")]
	public class UserVO
	{
		public var username:String;
		public var first_name:String;
		public var last_name:String;
		public var is_active:Boolean;
		public var id:int;
		public var is_superuser:Boolean;
		public var is_staff:Boolean;
		public var last_login:Date;
		public var groups:Array;
		public var user_permissions:Array;
		public var password:String;
		public var email:String;
		public var date_joined:Date;
	}	
}