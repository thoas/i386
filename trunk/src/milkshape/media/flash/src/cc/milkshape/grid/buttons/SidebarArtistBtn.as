package cc.milkshape.grid.buttons
{
	public class SidebarArtistBtn extends SidebarArtistBtnClp
	{
		public function SidebarArtistBtn(username:String, newArtist:Boolean = false)
		{
			buttonMode = true;
			textClp.label.text = username.toUpperCase();
			
			if(!newArtist) 
				featured.text = '';
		}
	}
}