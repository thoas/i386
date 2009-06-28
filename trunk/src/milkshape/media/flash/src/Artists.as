package
{
	import cc.milkshape.artists.ArtistsController;
	import cc.milkshape.artists.ArtistsView;
	
	import flash.display.Sprite;

	[SWF(width='960', height='600', frameRate='31', backgroundColor='#191919')]

	public class Artists extends Sprite
	{
		public function Artists()
		{
			var artistsController:ArtistsController = new ArtistsController();
			var artistsView:ArtistsView = new ArtistsView(artistsController);
			addChild(artistsView);
		}
	}
}