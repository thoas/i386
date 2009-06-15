package cc.milkshape.artists
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ArtistBtn extends ArtistBtnClp
	{
		private var _overStatut:Boolean;
		private var _issueBtn:IssueBtn;
		private var _siteBtn:SiteBtn;
		
		public function ArtistBtn(artistName:String)
		{
			buttonMode = true;
			_overStatut = false;
			
			stop();
			
			addEventListener(MouseEvent.ROLL_OVER, _overHandler);			
			addEventListener(MouseEvent.ROLL_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			textClp.label.text = artistName;
			
			_issueBtn = new IssueBtn();
			_siteBtn = new SiteBtn();
			issue.addChild(_issueBtn);
			site.addChild(_siteBtn);
			
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
			if (_overStatut) {
				nextFrame();
			} else if (currentLabel == 'end' || currentLabel == 'tween2') {
				nextFrame();
			} else {
				prevFrame();
			}
			
			if(currentLabel == 'end2')
				gotoAndStop('start')
				
			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			
		}
	}
}