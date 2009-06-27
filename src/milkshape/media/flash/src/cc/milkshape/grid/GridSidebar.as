package cc.milkshape.grid
{
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

			_nextFrame = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
			
			open.buttonMode = true;
			open.addEventListener(MouseEvent.CLICK, _clickHandler);
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
					_listArtists[SquareOwned(square).user.id] = new SidebarArtistBtn(SquareOwned(square).user.username);
					_listArtists[SquareOwned(square).user.id].y = decalY;
					decalY += 12;
					listArtists.addChild(_listArtists[SquareOwned(square).user.id]);
				}
			}
			
			// le premier ArtistBtn on est celui qui a le focus 
			if(_gridModel.focusSquare is SquareOwned)
			{
				_lastOverArtistBtn = _listArtists[_gridModel.focusSquare.user.id];
				_lastOverArtistBtn.gotoAndStop('on');
			}
			
			_gridModel.addEventListener(GridOverEvent.OVER, _overSquareHandler);
		}
		
		private function _overSquareHandler(e:GridOverEvent):void
		{
			if(_lastOverArtistBtn)
				_lastOverArtistBtn.gotoAndStop('off');
			_lastOverArtistBtn = _listArtists[e.userId];
			_lastOverArtistBtn.gotoAndStop('on');
			trace(_lastOverArtistBtn.textClp.label.text);
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