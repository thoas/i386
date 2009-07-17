package cc.milkshape.utils
{
	public class Constance
	{
		public static const ISSUE_SWF:String = 'Issue.swf';
		public static const ISSUES_SWF:String = 'Issues.swf';
		public static const ARTISTS_SWF:String = 'Artists.swf';
		public static const CONTACT_SWF:String = 'Contact.swf';
		public static const ACCOUNT_SWF:String = 'Account.swf';
		public static const HOME_SWF:String = 'Home.swf';
		public static const ABOUT_SWF:String = 'About.swf';
		public static const TERMS_SWF:String = 'Terms.swf';
		
		public static const ISSUE_POSX:int = 0;
		public static const ISSUE_POSY:int = 0;
		
		public static const CONSTANCE_XML_ROOT:String = 'http://localhost:8000/media/flash/src/assets/constance.xml';
		
		public static var URL_SITE:String = "http://localhost:8000";
		public static var GATEWAY_URL:String = "http://localhost:8000/gateway/";
		//public static var URL_SITE:String = "http://milkshape.cc";
		
		public static var COLOR_YELLOW:int = 0xffdd00;
		
		public static var COLOR_BLUE:int = 0x9df7ff;
		
		public static function url(url:String):String {
			return URL_SITE + "/" + url;
		}
	}
}