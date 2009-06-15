package cc.milkshape.artists
{
	import fl.data.DataProvider;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class PastilleBtn extends PastilleBtnClp
	{
		private var _overStatut:Boolean;
		private var _clickStatut:Boolean;
		private var _prevContinue:Boolean;
		private var _listArtists:Array;
		private var _artists:DataProvider;
		
		public function PastilleBtn(str:String, array:Array)
		{
			_artists = new DataProvider(array);
			_listArtists = array;
			buttonMode = true;
			stop();
			_overStatut = false;
			_clickStatut = false;
			_prevContinue = false;
			
			textClp.label.text = str;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			_overStatut = true;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			_overStatut = false;
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _enterFrame(e:Event):void
		{
			trace('ok');
			if (_overStatut && !_prevContinue) {
				nextFrame();
			} else {
				prevFrame();
			}
			
			if(currentLabel == 'start')
				_prevContinue = false;
				
			if (currentLabel == 'start' || (currentLabel == 'end' && !_prevContinue) || currentLabel == 'end2')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			dispatchEvent(new Event('CLICKED'));
			
			_clickStatut = true;
			
			removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			removeEventListener(MouseEvent.CLICK, _clickHandler);
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		public function initClick():void
		{
			gotoAndStop('end2');
			removeEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			removeEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			removeEventListener(MouseEvent.CLICK, _clickHandler);
			_clickStatut = true;
		}
		
		public function reinitClick():void
		{
			_clickStatut = false;
			_prevContinue = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			
			if (!hasEventListener(Event.ENTER_FRAME))
				addEventListener(Event.ENTER_FRAME, _enterFrame);
		}

		public function get listArtists():Array
		{
			return _listArtists;
		}

		public function set listArtists(v:Array):void
		{
			_listArtists = v;
		}

		public function get artists():DataProvider
		{
			return _artists;
		}

		public function set artists(v:DataProvider):void
		{
			_artists = v;
		}
		
		public function sortByName():void
		{
			_artists.sortOn('name');
		}
		
		public function sortByDate():void
		{
			_artists.sortOn('date');
		}


	}
}