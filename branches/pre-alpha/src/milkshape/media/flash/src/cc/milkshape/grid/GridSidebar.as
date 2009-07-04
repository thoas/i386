package cc.milkshape.grid
{
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.grid.buttons.SidebarArtistBtn;
	import cc.milkshape.grid.events.GridEvent;
	import cc.milkshape.grid.events.GridOverEvent;
	import cc.milkshape.grid.square.Square;
	import cc.milkshape.grid.square.SquareManager;
	import cc.milkshape.grid.square.SquareOwned;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GridSidebar extends SidebarClp
	{
		private var _listArtists:Array;
		private var _nextFrame:Boolean;
		private var _gridModel:GridModel;
		private var _lastOverArtistBtn:SidebarArtistBtn;
		
		public function GridSidebar(gridModel:GridModel)
		{
			_gridModel = gridModel;
			_gridModel.addEventListener(GridEvent.READY, _gridReadyHandler);
			stop();
			
			open.buttonMode = true;
			open.addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		public function show():void
		{
			_nextFrame = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _gridReadyHandler(e:GridEvent):void
		{
			_listArtists = new Array();
			var square:Square;
			var decalY:int = 0;
			for(var i:int = 0; i < SquareManager.length(); i++)
			{
				square = SquareManager.get(i);
				if(square is SquareOwned)
				{
					_listArtists[i] = new SidebarArtistBtn(SquareOwned(square).user.username);
					_listArtists[i].y = decalY;
					decalY += 12;
					listArtists.addChild(_listArtists[i]);
				}
			}
			
			openDate.label.text = _gridModel.issue.date_created.month + '.' + _gridModel.issue.date_created.date + '.' + _gridModel.issue.date_created.fullYear;
			title.label.text = _gridModel.issue.title;
			desc.label.htmlText = _gridModel.issue.text_presentation;
			openItem.label.text = _gridModel.issue.nb_squares_open;
			booked.label.text = _gridModel.issue.nb_squares_booked;
			full.label.text =  _gridModel.issue.nb_creators;
			
			if(true)
			{
				decalY -= 11;
				bg.download.addChild(new SmallButton('DOWNLOAD', new DownloadItem()));
				bg.bg.height += decalY + 5;
				bg.download.y += decalY + 3;
				bg.bottomBar.y += decalY;
			}
			else
			{
				decalY -= 41;
				bg.bg.height += decalY + 5;
				bg.bottomBar.alpha = 0;
			}
			
			
			// le premier ArtistBtn on est celui qui a le focus 
			if(_gridModel.focusSquare is SquareOwned)
			{
				_lastOverArtistBtn = _listArtists[SquareManager.getIndice(_gridModel.focusSquare)];
				_lastOverArtistBtn.on();
			}
			
			_gridModel.addEventListener(GridOverEvent.OVER, _overSquareHandler);
		}
		
		private function _overSquareHandler(e:GridOverEvent):void
		{
			if(_lastOverArtistBtn)
				_lastOverArtistBtn.off();
			_lastOverArtistBtn = _listArtists[e.indice];
			_lastOverArtistBtn.on();
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			_nextFrame = !_nextFrame;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}

		private function _enterFrame(e:Event):void
		{
			if(_nextFrame)
				nextFrame();
			else
				prevFrame();

			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
	}
}