package cc.milkshape.gateway.vo
{
    [RemoteClass(alias="cc.milkshape.gateway.vo.UserVO")]
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
		
		public function UserVO(
			username:String = "", 
			first_name:String = "", 
			last_name:String = "",
			is_active:Boolean = false,
			id:int = 0,
			is_superuser:Boolean = false,
			is_staff:Boolean = false,
			last_login:Date = undefined,
			groups:Array = undefined,
			user_permissions:Array = undefined,
			password:String = "",
			email:String = "",
			date_joined:Date = undefined){
			
			this.username = username;
			this.first_name = first_name;
			this.last_name = last_name;
			this.is_active = is_active;
			this.id = id;
			this.is_superuser = is_superuser;
			this.is_staff = is_staff;
			this.last_login = last_login;
			this.groups = groups;
			this.user_permissions = user_permissions;
			this.password = password;
			this.email = email;
			this.date_joined = date_joined;		
		}
	}	
}