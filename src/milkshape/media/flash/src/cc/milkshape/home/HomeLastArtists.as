package cc.milkshape.home
{
	import cc.milkshape.utils.SmallButton;
	
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
				if(decalX + artistButton.width > 200)
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
			
			_allArtistBtn = new SmallButton("MON TEST A MOI", new PlusItem());
			_allArtistBtn.x = 180;
			_allArtistBtn.y = decalY + 30;
			addChild(_allArtistBtn);
			
			
		}
	}
}