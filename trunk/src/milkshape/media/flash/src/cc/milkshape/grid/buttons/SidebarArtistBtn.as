package cc.milkshape.grid.buttons
{
	public class SidebarArtistBtn extends SidebarArtistBtnClp
	{
		public function SidebarArtistBtn(username:String, newArtist:Boolean = false)
		{
			buttonMode = true;
			textClp.label.text = username.toUpperCase();
			
			if(!newArtist) 
			{
				featured.text = '';
			}
			else
			{
				featured.x = 0;
				textClp.label.x =+ 28;
			}
		}
	}
}