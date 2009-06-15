package
{
	import cc.milkshape.artists.*;
	import cc.milkshape.utils.SmallButton;
	
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Cubic;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[SWF(width='960', height='600', frameRate='31', backgroundColor='#191919')]

	public class Artists extends MovieClip
	{
		private var _all:PastilleBtn;
		private var _maxArtists:int;
		private var _artistsClp:ArtistsClp;
		private var _listArtistsContainer:Array;
		private var _listIssuesContainer:Array;
		private var _lastPastilleBtnClicked:PastilleBtn;
		private var _az:SmallButton;
		private var _date:SmallButton;
		
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
							{name: 'Edith', url: 'qsdqsd', date: 899876},
							{name: 'Carron', url: 'qsdqsd', date: 9870987},
							{name: 'Tabas', url: 'qsdqsd', date: 9867086},
							{name: 'Mathilde Aubier', url: 'qsdqsd', date: 896876},
							{name: 'Nodar', url: 'qsdqsd', date: 876765},
							{name: 'David Benmussa', url: 'qsdqsd', date: 65564},
							{name: 'Nepomuk', url: 'qsdqsd', date: 65465},
							{name: 'Topdos', url: 'qsdqsd', date: 785675},
							{name: 'Malota', url: 'qsdqsd', date: 764654},
							{name: 'CrazyBoys', url: 'qsdqsd', date: 675675467},
							{name: 'Edith Carron', url: 'qsdqsd', date: 675674765}
						)
					},
					{
						num: '2',
						artists: new Array( 
							{name: 'Edith', url: 'qsdqsd', date: 764657467},
							{name: 'Carron', url: 'qsdqsd', date: 76786789}
						)
					},
					{
						num: '3',
						artists: new Array( 
							{name: 'David Benmussa', url: 'qsdqsd', date: 9798067},
							{name: 'Nepomuk', url: 'qsdqsd', date: 87598779},
							{name: 'Topdos', url: 'qsdqsd', date: 7869878},
							{name: 'Malota', url: 'qsdqsd', date: 452456},
							{name: 'CrazyBoys', url: 'qsdqsd', date: 980708},
							{name: 'Edith Carron', url: 'qsdqsd', date: 3445366}
						)
					}
				)
			};
			
			_onResult(oGateway);
			
		}
		
		private function _onResult(o:Object):void
		{
			_maxArtists = 10;
			_listArtistsContainer = new Array();
			_listIssuesContainer = new Array();
			
			_artistsClp = new ArtistsClp();
			addChild(_artistsClp);
			
			var i:int = 0;
			for each(var issue:Object in o.issues)
			{
				var pastille:PastilleBtn = new PastilleBtn('#' + issue.num, issue.artists);
				pastille.addEventListener('CLICKED', _clickPastilleHandler);
				pastille.x = i * 70;
				_artistsClp.issues.addChild(pastille);
				_listIssuesContainer.push(pastille);
				i++;
			}
			
			_all = new PastilleBtn('All', _getAllArtists(o.issues));
			_all.initClick();
			_all.addEventListener('CLICKED', _clickPastilleHandler);
			_lastPastilleBtnClicked = _all;
			_createArtistsContainer();
			_artistsClp.all.addChild(_all);
						
			_az = new SmallButton('A-Z', new PlusItem());
			_az.addEventListener(MouseEvent.CLICK, _sortByName);
			_artistsClp.az.addChild(_az);
			
			_date = new SmallButton('DATE', new PlusItem());
			_date.addEventListener(MouseEvent.CLICK, _sortByDate);
			_artistsClp.date.addChild(_date);
		}
		
		private function _sortByName(e:MouseEvent):void
		{
			_lastPastilleBtnClicked.sortByName();
			_refreshPastille();
		}
		
		private function _sortByDate(e:MouseEvent):void
		{
			_lastPastilleBtnClicked.sortByDate();
			_refreshPastille();
		}
		
		private function _clickPastilleHandler(e:Event):void
		{
			_removeArtistsContainer();
			_lastPastilleBtnClicked.reinitClick();
			_lastPastilleBtnClicked = e.currentTarget as PastilleBtn;
			_createArtistsContainer();
		}
		
		private function _refreshPastille():void
		{
			_removeArtistsContainer();
			_createArtistsContainer();
		}
		
		private function _getAllArtists(issues:Array):Array
		{
			var array:Array = new Array();
			for each (var o:Object in issues)
			{
				for each (var a:Object in o.artists)
				{
					array.push(a);
				}
			}
			return array;
		}
		
		private function _removeArtistsContainer():void
		{
			var nbArtistsContainer:int = Math.ceil(_lastPastilleBtnClicked.listArtists.length / _maxArtists);
			
			for(var i:int = 0; i < nbArtistsContainer; i++)
			{
				_artistsClp.names.removeChild(_listArtistsContainer.shift());
			}
		}
		
		private function _createArtistsContainer():void
		{
			var listArtists:Array = _lastPastilleBtnClicked.artists.toArray();
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