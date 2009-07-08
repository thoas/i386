package cc.milkshape.navigation.home.view
{
	import cc.milkshape.preloader.PreloaderWiper;
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.utils.Constance;
	import cc.milkshape.navigation.generic.PrivateEventList;
	
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.ObjectEvent;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class HomeIssuePreviewUI extends AbstractView
	{
		private var _overStatut:Boolean;
		private var _issue:Object;
		
		public function HomeIssuePreviewUI(issue:Object, owner:Plugin=null, name:String=null, mc:DisplayObject=null):void
		{
			super(owner, name, mc);
			_issue = issue;
			_overStatut = false;
			
			var thumbUrl:String = issue.thumb_url ? issue.thumb_url:Constance.DEFAULT_ISSUE_THUMB;
			var img:PreloaderWiper = new PreloaderWiper();
			
			with(view as HomeIssuePreviewClp){
				buttonMode = true;
				stop();
				
				addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
				addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
				addEventListener(MouseEvent.CLICK, _clickHandler);
				
				titleClp.label.text = issue.title;
				infoClp.label.htmlText = issue.text_presentation;
				img.loadMedia(thumbUrl);
				bg.addChild(img);
			}
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			_overStatut = true;
			
			if (!(view as HomeIssuePreviewClp).hasEventListener(Event.ENTER_FRAME))
				(view as HomeIssuePreviewClp).addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			_overStatut = false;
			
			if (!(view as HomeIssuePreviewClp).hasEventListener(Event.ENTER_FRAME))
				(view as HomeIssuePreviewClp).addEventListener(Event.ENTER_FRAME, _enterFrame);
		}
		
		private function _enterFrame(e:Event):void
		{
			if (_overStatut)
				(view as HomeIssuePreviewClp).nextFrame();
			else
				(view as HomeIssuePreviewClp).prevFrame();
			
			var currentLabel:String = (view as HomeIssuePreviewClp).currentLabel;
			if (currentLabel == 'start' || currentLabel == 'end')
			{
				(view as HomeIssuePreviewClp).removeEventListener(Event.ENTER_FRAME, _enterFrame);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			EventBroadcaster.getInstance().broadcastEvent(new ObjectEvent(PrivateEventList.onClickIssuePreviewUI, {
				url: Constance.ISSUE_SWF, 
				background: false,
				posX: Constance.ISSUE_POSX, 
				posY: Constance.ISSUE_POSY,  
				params: {slug: _issue.slug}
			}));
		}
	}
}