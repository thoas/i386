package cc.milkshape.utils
{
	public class Constance
	{
		public static const ISSUE_SWF:String = 'issue.swf';
		public static const ISSUES_SWF:String = 'issues.swf';
		public static const ARTISTS_SWF:String = 'artists.swf';
		public static const CONTACT_SWF:String = 'contact.swf';
		public static const ACCOUNT_SWF:String = 'account.swf';
		public static const HOME_SWF:String = 'home.swf';
		public static const ABOUT_SWF:String = 'about.swf';
		public static const TERMS_SWF:String = 'terms.swf';
		
		public static const ISSUE_POSX:int = 0;
		public static const ISSUE_POSY:int = 37;
		
		public static const DEFAULT_ISSUE_THUMB:String = 'assets/vignette_pattern.jpg';
		
		public static var URL_SITE:String = "http://localhost:8000";
		
		public static var COLOR_YELLOW:int = 0xffdd00;
		
		public static var COLOR_BLUE:int = 0x9df7ff;
		
		public static function url(url:String):String {
			return URL_SITE + "/" + url;
		}
	}
}