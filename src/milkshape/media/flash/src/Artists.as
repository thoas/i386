package
{
	import cc.milkshape.artists.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.gskinner.motion.GTween;	
	import fl.motion.easing.Cubic;

	[SWF(width='960', height='600', frameRate='31', backgroundColor='#191919')]

	public class Artists extends MovieClip
	{
		private var _all:PastilleBtn;
		private var _maxArtists:int;
		private var _artistsClp:ArtistsClp;
		private var _listArtistsContainer:Array;
		private var _listIssues:Array;
		private var _listIssuesContainer:Array;
		private var _lastPastilleBtnClicked:PastilleBtn;
		
		public function Artists()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			var oGateway:Object = {
				issues: new Array(
					{
						num: '1',
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
					},
					{
						num: '2',
						artists: new Array( 
							{name: 'Edith', url: 'qsdqsd'},
							{name: 'Carron', url: 'qsdqsd'}
						)
					},
					{
						num: '3',
						artists: new Array( 
							{name: 'David Benmussa', url: 'qsdqsd'},
							{name: 'Nepomuk', url: 'qsdqsd'},
							{name: 'Topdos', url: 'qsdqsd'},
							{name: 'Malota', url: 'qsdqsd'},
							{name: 'CrazyBoys', url: 'qsdqsd'},
							{name: 'Edith Carron', url: 'qsdqsd'}
						)
					}
				)
			};
			
			_onResult(oGateway);
			
		}
		
		private function _onResult(o:Object):void
		{
			_listArtistsContainer = new Array();
			_listIssues = o.issues;
			_maxArtists = 10;
			
			_artistsClp = new ArtistsClp();
			addChild(_artistsClp);
			
			_all = new PastilleBtn('All', _getAllArtists());
			_all.initClick();
			_all.addEventListener('CLICKED', _clickPastilleHandler);
			_artistsClp.all.addChild(_all);
			
			_lastPastilleBtnClicked = _all;

			_createIssuesContainer();			
			_createArtistsContainer(_all.listArtists);
		}
		
		private function _clickPastilleHandler(e:Event):void
		{
			_removeArtistsContainer();
			_lastPastilleBtnClicked.reinitClick();
			_lastPastilleBtnClicked = e.currentTarget as PastilleBtn;
			_createArtistsContainer(_lastPastilleBtnClicked.listArtists);
		}
		
		private function _getAllArtists():Array
		{
			var array:Array = new Array();
			for each (var o:Object in _listIssues)
			{
				for each (var a:Object in o.artists)
				{
					array.push(a);
				}
			}
			return array;
		}
		
		private function _createIssuesContainer():void
		{
			_listIssuesContainer = new Array();
			
			var i:int = 0;
			for each(var issue:Object in _listIssues)
			{
				var pastille:PastilleBtn = new PastilleBtn('#' + issue.num, issue.artists);
				pastille.addEventListener('CLICKED', _clickPastilleHandler);
				pastille.x = i * 70;
				i++;
				_artistsClp.issues.addChild(pastille);
				_listIssuesContainer.push(pastille);
			}
		}
		
		private function _createArtistsContainer(listArtists:Array):void
		{			
			var nbArtistsContainer:int = Math.ceil(listArtists.length / _maxArtists);
			
			for(var i:int = 0; i < nbArtistsContainer; i++)
			{
				var mc:MovieClip = new MovieClip();
				mc.x = i*360;
				_artistsClp.names.addChild(mc);
				_listArtistsContainer.push(mc);
			}
			
			_putArtistsInContainer(listArtists);
		}
		
		private function _removeArtistsContainer():void
		{
			var nbArtistsContainer:int = Math.ceil(_lastPastilleBtnClicked.listArtists.length / _maxArtists);
			
			for(var i:int = 0; i < nbArtistsContainer; i++)
			{
				_artistsClp.names.removeChild(_listArtistsContainer.shift());
			}
		}
		
		private function _putArtistsInContainer(listArtists:Array):void
		{
			var decalY:int = 0;
			var i:int = 0;
			var j:int = 0;
			for each(var artist:Object in listArtists)
			{
				var artistBtn:ArtistBtn = new ArtistBtn(artist.name);
				artistBtn.y = 400;
				artistBtn.x = 400;
				new GTween(artistBtn, 0.5, { y: decalY, x: 0 }, { ease:Cubic.easeInOut, delay: i > 0 ? i * 0.1 : 0 });
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