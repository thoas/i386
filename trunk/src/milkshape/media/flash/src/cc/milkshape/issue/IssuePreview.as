package cc.milkshape.issue
{
	import cc.milkshape.preloader.PreloaderWiper;
	
	import flash.events.MouseEvent;

	public class IssuePreview extends IssuePreviewClp
	{
		public function IssuePreview(issue:Object)
		{
			addEventListener(MouseEvent.ROLL_OVER, _overHandler);
			addEventListener(MouseEvent.ROLL_OUT, _outHandler);
			over.alpha = 0.7;
			buttonMode = true;
			pastilleClp.stop();
			titleClp.descLabel.htmlText = issue.text_presentation;
			titleClp.titleLabel.text = issue.title;
			infoClp.creatorsLabel.text = issue.nb_creators + ' CREATORS';
			infoClp.squaresLabel.text = issue.nb_squares + ' SQUARES';
			scheduleClp.scheduleLabel.text = issue.date_created;
			pastilleClp.textClp.label.text = '#' + issue.id;
				
			var img:PreloaderWiper = new PreloaderWiper();
			img.loadMedia(issue.thumb_url);
			
			loaderClp.addChild(img);
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