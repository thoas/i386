package cc.milkshape.home
{
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.home.buttons.*;
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.utils.Constance;
	
	import flash.events.MouseEvent;

	public class HomeLastArtists extends HomeLastArtistsClp
	{
		private var _allArtistBtn:SmallButton;
		
		public function init(a:Array):void
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
			_allArtistBtn.addEventListener(MouseEvent.CLICK, _handlerClick);
			allArtists.addChild(_allArtistBtn);		
		}
		
		private function _handlerClick(e:MouseEvent):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {
				url: Constance.ARTISTS_SWF
			}));
		}
	}
}