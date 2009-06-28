package cc.milkshape.artists
{
	import cc.milkshape.artists.buttons.*;
	import cc.milkshape.artists.events.ArtistsEvent;
	import cc.milkshape.framework.buttons.ArrowButton;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.mvc.View;
	
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Cubic;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ArtistsView extends View
	{
		private var _artistsController:ArtistsController;
		private var _all:PastilleButton;
		private var _maxArtists:int;
		private var _artistsClp:ArtistsClp;
		private var _listArtistsContainer:Array;
		private var _listIssuesContainer:Array;
		private var _lastPastilleBtnClicked:PastilleButton;
		private var _az:SmallButton;
		private var _date:SmallButton;
		private var _arrowRight:ArrowButton;
		private var _arrowLeft:ArrowButton;
		private var _arrowRightIssue:ArrowButton;
		private var _arrowLeftIssue:ArrowButton;
		private var _nbArtistsContainer:int;
		private var _nbIssuesContainer:int;
		private var _countArtistsContainer:int;
		private var _countIssuesContainer:int;
		private var _maskModified:Boolean;
		
		public function ArtistsView(artistsController:ArtistsController)
		{
			_artistsController = artistsController;
			_artistsController.addEventListener(ArtistsEvent.SQUARES_BY_ISSUES_LOADED, _squaresByIssuesLoaded);
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_artistsController.issues();
		}
		
		private function _squaresByIssuesLoaded(e:ArtistsEvent):void
		{
			_maxArtists = 13;
			_listArtistsContainer = new Array();
			_listIssuesContainer = new Array();
			
			_artistsClp = new ArtistsClp();
			addChild(_artistsClp);
			_createArrows();
			
			_nbIssuesContainer = e.issues.length;
			var issues:Array = e.issues;
			
			if(_nbIssuesContainer > 10)
				_artistsClp.arrowRightIssue.addChild(_arrowRightIssue);
				
			for(var i:int = 0; i < _nbIssuesContainer; i++)			
			{
				var pastille:PastilleButton = new PastilleButton('#' + issues[i].issue.id, issues[i].squares);
				pastille.addEventListener('CLICKED', _clickPastilleHandler);
				pastille.x = 800;
				new GTween(pastille, 0.5, { x: i * 62 }, { ease:Cubic.easeInOut, delay: i > 0 ? i * 0.1 : 0 });				
				_artistsClp.issues.addChild(pastille);
				_listIssuesContainer.push(pastille);
			}
			
			_all = new PastilleButton('All', _getAllArtists(issues));
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
		
		private function _inversePosition(mc:DisplayObject):void
		{
			mc.rotation = 180;
			mc.x += mc.width;
			mc.y += mc.height;
		}
		
		private function _createArrows():void
		{
			_arrowRight = new ArrowButton();
		 	_arrowLeft = new ArrowButton();
			_arrowRightIssue = new ArrowButton();
			_arrowLeftIssue = new ArrowButton();
			
			_inversePosition(_arrowLeft);
			_inversePosition(_arrowLeftIssue);
			
			_arrowsListnerEnabled();
		}
		
		private function _arrowsListnerDisabled(e:Event = null):void
		{
			_arrowRight.removeEventListener(MouseEvent.CLICK, _nextArtists);
			_arrowLeft.removeEventListener(MouseEvent.CLICK, _prevArtists);
			_arrowRightIssue.removeEventListener(MouseEvent.CLICK, _nextIssues);
			_arrowLeftIssue.removeEventListener(MouseEvent.CLICK, _prevIssues);
		}
		
		private function _arrowsListnerEnabled(e:Event = null):void
		{
			_arrowRight.addEventListener(MouseEvent.CLICK, _nextArtists);
			_arrowLeft.addEventListener(MouseEvent.CLICK, _prevArtists);
			_arrowRightIssue.addEventListener(MouseEvent.CLICK, _nextIssues);
			_arrowLeftIssue.addEventListener(MouseEvent.CLICK, _prevIssues);
		}
		
		private function _initArrows():void
		{
			try {_artistsClp.arrowRight.removeChild(_arrowRight);} catch(e:Error) {}
			try {_artistsClp.arrowLeft.removeChild(_arrowLeft);} catch(e:Error) {}
			
			_artistsClp.names.x = 45;
			_countArtistsContainer = 0;
		}
		
		private function _modifyMask(b:Boolean):void
		{
			if(b && !_maskModified)
			{
				_maskModified = true;
				_artistsClp.maskIssues.width -= 62;
				_artistsClp.maskIssues.x += 62;
			}
			else if (!b)
			{
				_maskModified = false;
				_artistsClp.maskIssues.width += 62;
				_artistsClp.maskIssues.x -= 62;
			}
		}
		
		private function _checkArrowsIssues(op:int):void
		{
			_countIssuesContainer += op;
			
			if(_countIssuesContainer < 1)
			{
				_artistsClp.arrowLeftIssue.removeChild(_arrowLeftIssue);
				_artistsClp.arrowRightIssue.addChild(_arrowRightIssue);
				_modifyMask(false);
			}
			else if(_countIssuesContainer >= _nbIssuesContainer - 10)
			{
				_artistsClp.arrowRightIssue.removeChild(_arrowRightIssue);
				_artistsClp.arrowLeftIssue.addChild(_arrowLeftIssue);
				_modifyMask(true);
			}
			else
			{
				_artistsClp.arrowLeftIssue.addChild(_arrowLeftIssue);
				_modifyMask(true);
			}
		}
		
		private function _checkArrows(op:int):void
		{
			_countArtistsContainer += op;
			
			if(_countArtistsContainer < 1)
			{
				_artistsClp.arrowLeft.removeChild(_arrowLeft);
				_artistsClp.arrowRight.addChild(_arrowRight);
			}
			else if(_countArtistsContainer >= _nbArtistsContainer - 2)
			{
				_artistsClp.arrowRight.removeChild(_arrowRight);
				_artistsClp.arrowLeft.addChild(_arrowLeft);
			}
			else
			{
				_artistsClp.arrowLeft.addChild(_arrowLeft);
			}
		}
		
		private function _nextArtists(e:MouseEvent):void
		{
			_arrowsListnerDisabled();
			new GTween(_artistsClp.names, 0.5, { x: _artistsClp.names.x - 360 }, { ease:Cubic.easeInOut, completeListener:_arrowsListnerEnabled });	
			_checkArrows(1);
		}
		
		private function _prevArtists(e:MouseEvent):void
		{
			_arrowsListnerDisabled();
			new GTween(_artistsClp.names, 0.5, { x: _artistsClp.names.x + 360 }, { ease:Cubic.easeInOut, completeListener:_arrowsListnerEnabled });
			_checkArrows(-1);
		}
		
		private function _nextIssues(e:MouseEvent):void
		{
			_arrowsListnerDisabled();
			new GTween(_artistsClp.issues, 0.5, { x: _artistsClp.issues.x - 62 }, { ease:Cubic.easeInOut, completeListener:_arrowsListnerEnabled });
			_checkArrowsIssues(1);
		}
		
		private function _prevIssues(e:MouseEvent):void
		{
			_arrowsListnerDisabled();
			new GTween(_artistsClp.issues, 0.5, { x: _artistsClp.issues.x + 62 }, { ease:Cubic.easeInOut, completeListener:_arrowsListnerEnabled });
			_checkArrowsIssues(-1);
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
			_initArrows();
			_removeArtistsContainer();
			_lastPastilleBtnClicked.reinitClick();
			_lastPastilleBtnClicked = e.currentTarget as PastilleButton;
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
				for each (var a:Object in o.squares)
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
			_nbArtistsContainer = Math.ceil(listArtists.length / _maxArtists);
			
			if(_nbArtistsContainer > 2)
				_artistsClp.arrowRight.addChild(_arrowRight);
			
			for(var i:int = 0; i < _nbArtistsContainer; i++)
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
				var artistBtn:ArtistButton = new ArtistButton(artist.user.username, artist.pos_x, artist.pos_y, artist.issue.slug);
				if(i < 2 * _maxArtists)
				{
					artistBtn.y = 400;
					new GTween(artistBtn, 0.2, { y: decalY }, { ease:Cubic.easeInOut, delay: i > 0 ? i * 0.04 : 0 });
				}
				else
				{
					artistBtn.y = decalY;
				}				
				decalY += 26;
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