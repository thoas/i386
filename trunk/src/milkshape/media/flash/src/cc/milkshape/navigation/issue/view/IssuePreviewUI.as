package cc.milkshape.navigation.issue.view
{
	import cc.milkshape.preloader.PreloaderWiper;
	import cc.milkshape.utils.Constance;
	import cc.milkshape.navigation.generic.PrivateEventList;
	
	import com.bourre.events.EventBroadcaster;
	import com.bourre.plugin.Plugin;
	import com.bourre.events.ObjectEvent;
	import com.bourre.view.AbstractView;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	public class IssuePreviewUI extends AbstractView
	{
		private var _issue:Object;
		public function IssuePreviewUI(issue:Object, owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
			var thumbUrl:String = issue.thumb_url ? issue.thumb_url:Constance.DEFAULT_ISSUE_THUMB;
			var img:PreloaderWiper = new PreloaderWiper();
			_issue = issue;
			with(view as IssuePreviewClp)
			{
				addEventListener(MouseEvent.ROLL_OVER, _overHandler);
				addEventListener(MouseEvent.ROLL_OUT, _outHandler);
				addEventListener(MouseEvent.CLICK, _clickHandler);
				over.alpha = 0.7;
				buttonMode = true;
				pastilleClp.stop();
				titleClp.descLabel.htmlText = issue.text_presentation;
				titleClp.titleLabel.text = issue.title;
				infoClp.creatorsLabel.text = issue.nb_creators + ' CREATORS';
				infoClp.squaresLabel.text = issue.nb_case_x * issue.nb_case_y + ' SQUARES';
				scheduleClp.scheduleLabel.text = 'OPENED ' + issue.date_created.month + '.' + issue.date_created.date + '.' + issue.date_created.fullYear;
				pastilleClp.textClp.label.text = '#' + issue.id;
				
				img.loadMedia(thumbUrl);
				loaderClp.addChild(img);
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
		
		private function _overHandler(e:MouseEvent):void
		{
			(view as IssuePreviewClp).over.alpha = 0;
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			(view as IssuePreviewClp).over.alpha = 0.7;
		}
	}
}