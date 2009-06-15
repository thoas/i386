package
{
	import cc.milkshape.artists.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	[SWF(width='960', height='600', frameRate='31', backgroundColor='#191919')]

	public class Artists extends MovieClip
	{
		private var _all:PastilleBtn;
		private var _maxArtists:int;
		private var _artistsClp:ArtistsClp;
		private var _listArtistsContainer:Array;
		private var _listArtists:Array;
		
		public function Artists()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			var oGateway:Object = {
				artists: new Array(
					{name: 'Edith', url: 'qsdqsd'},
					{name: 'Carron', url: 'qsdqsd'},
					{name: 'Tabas', url: 'qsdqsd'},
					{name: 'Mathilde Aubier', url: 'qsdqsd'},
					{name: 'Nodar', url: 'qsdqsd'},
					{name: 'David Benmussa', url: 'qsdqsd'},
					{name: 'Nepomuk', url: 'qsdqsd'},
					{name: 'Topdos', url: 'qsdqsd'},
					{name: 'Malota', url: 'qsdqsd'},
					{name: 'CrazyBoys', url: 'qsdqsd'},
					{name: 'Edith Carron', url: 'qsdqsd'}
				)
			};
			
			_onResult(oGateway);
			
		}
		
		private function _onResult(o:Object):void
		{
			_listArtists = o.artists;
			_maxArtists = 4;
			
			_artistsClp = new ArtistsClp();
			addChild(_artistsClp);
			
			_all = new PastilleBtn('All');
			addChild(_all);

			_createArtistsContainer();			
			
		}
		
		private function _createArtistsContainer():void
		{
			_listArtistsContainer = new Array();
			
			var nbArtistsContainer:int = Math.round(_listArtists.length / _maxArtists);
			trace(nbArtistsContainer);
			for(var i:int = 0; i < nbArtistsContainer; i++)
			{
				var mc:MovieClip = new MovieClip();
				mc.x = i*360;
				_artistsClp.names.addChild(mc);
				_listArtistsContainer.push(mc);
			}
			
			_putArtistsInContainer();
		}
		
		private function _putArtistsInContainer():void
		{
			var decalY:int = 0;
			var i:int = 0;
			var j:int = 0;
			for each(var artist:Object in _listArtists)
			{
				var artistBtn:ArtistBtn = new ArtistBtn(artist.name);
				artistBtn.y = decalY;
				decalY += 40;
				_listArtistsContainer[j].addChild(artistBtn);
				i++;
				if(i % _maxArtists == 0)
				{
					j++;
					decalY = 0;
				}
				
			}
		}
	}
}