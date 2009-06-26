package cc.milkshape.issue
{
	import Main;
	import cc.milkshape.utils.Constance;
	import cc.milkshape.preloader.PreloaderWiper;
	import cc.milkshape.preloader.events.PreloaderEvent;
	import flash.events.MouseEvent;

	public class IssuePreview extends IssuePreviewClp
	{
		private var _issue:Object;
		public function IssuePreview(issue:Object)
		{
			_issue = issue;
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
			scheduleClp.scheduleLabel.text = issue.date_created.month + '.' + issue.date_created.date + '.' + issue.date_created.fullYear;
			pastilleClp.textClp.label.text = '#' + issue.id;
			
			if(issue.thumb_url){
				var img:PreloaderWiper = new PreloaderWiper();
				img.loadMedia(issue.thumb_url);
				
				loaderClp.addChild(img);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {url: Constance.ISSUE_SWF, background: false, params: {slug: _issue.slug}}));
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			over.alpha = 0;
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			over.alpha = 0.7;
		}
	}
}