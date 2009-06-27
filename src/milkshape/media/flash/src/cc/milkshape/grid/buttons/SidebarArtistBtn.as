package cc.milkshape.grid.buttons
{
	import cc.milkshape.utils.Constance;
	
	public class SidebarArtistBtn extends SidebarArtistBtnClp
	{
		public static var i:int;
		public function SidebarArtistBtn(str:String, newArtist:Boolean = false)
		{
			buttonMode = true;
			username.text = str.toUpperCase();
			
			if(!newArtist) 
			{
				featured.text = '';
			}
			else
			{
				featured.x = 0;
				username.x =+ 28;
			}
			i++;
		}
		
		public function on():void
		{
			trace(i);
			username.textColor = Constance.COLOR_BLUE;
		}
		
		public function off():void
		{
			username.textColor = 0xffffff;
		}
	}
}