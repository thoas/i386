package cc.milkshape.artists.buttons
{
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.utils.Constance;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ArtistButton extends ArtistBtnClp
	{
		private var _overStatut:Boolean;
		private var _issueBtn:IssueButton;
		private var _siteBtn:SiteButton;
		private var _posX:int;
		private var _posY:int;
		private var _issueSlug:String
		
		public function ArtistButton(artistName:String, posX:int, posY:int, issueSlug:String)
		{
			buttonMode = true;
			_posX = posX;
			_posY = posY;
			_issueSlug = issueSlug;
			_overStatut = false;
			
			stop();
			
			addEventListener(MouseEvent.ROLL_OVER, _overHandler);			
			addEventListener(MouseEvent.ROLL_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			textClp.label.text = artistName;
			
			_issueBtn = new IssueButton();
			_siteBtn = new SiteButton();
			issue.addChild(_issueBtn);
			issue.addEventListener(MouseEvent.CLICK, _clickIssueHandler);
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
		
		private function _clickIssueHandler(e:MouseEvent):void
		{
			/*
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {
				url: Constance.ISSUE_SWF, 
				background: false,
				posX: Constance.ISSUE_POSX,
				posY: Constance.ISSUE_POSY, 
				params: {slug: _issueSlug, focusX: _posX, focusY: _posY}
			}));*/
		}
	}
}