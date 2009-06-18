package cc.milkshape.home
{
	import cc.milkshape.utils.buttons.SmallButton;
	import cc.milkshape.home.buttons.*;
	
	public class HomeLastArtists extends HomeLastArtistsClp
	{
		private var _allArtistBtn:SmallButton;
		
		public function HomeLastArtists(a:Array)
		{
			var decalX:int = 0;
			var decalY:int = 0;
			var artistButton:HomeArtistButton;
			
			var pair:Boolean = true;
			for each(var o:Object in a)
			{
				artistButton = new HomeArtistButton(o, pair);
				if(decalX + artistButton.width > 225)
				{
					decalX = 0;
					decalY += 20;
				}
				artistButton.y = decalY;
				artistButton.x = decalX;
				decalX += artistButton.width + 10; 
				preview1.addChild(artistButton);
				pair = !pair;
			}
			
			_allArtistBtn = new SmallButton("ALL ARTISTS", new PlusItem());
			_allArtistBtn.x = 155;
			_allArtistBtn.y = decalY + 90;
			addChild(_allArtistBtn);		
			
		}
	}
}