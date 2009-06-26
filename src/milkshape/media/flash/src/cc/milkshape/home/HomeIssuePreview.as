package cc.milkshape.home
{
	import cc.milkshape.preloader.PreloaderWiper;
	import cc.milkshape.preloader.events.PreloaderEvent;
	
	import cc.milkshape.utils.Constance;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class HomeIssuePreview extends HomeIssuePreviewClp
	{
		private var _overStatut:Boolean;
		private var _issue:Object;
		
		public function HomeIssuePreview(issue:Object) 
		{
			_issue = issue;
			buttonMode = true;
			stop();
			_overStatut = false;
			
			addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
			addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			
			titleClp.label.text = issue.title;
			infoClp.label.htmlText = issue.text_presentation;
			if(issue.thumb_url)
			{
				var img:PreloaderWiper = new PreloaderWiper();
				img.loadMedia(issue.thumb_url);
				bg.addChild(img);	
			}			
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
			if (_overStatut)
				nextFrame();
			else
				prevFrame();

			if (currentLabel == 'start' || currentLabel == 'end')
			{
				removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {url: Constance.ISSUE_SWF, background: false, params: {slug: _issue.slug}}));
		}
	}
}