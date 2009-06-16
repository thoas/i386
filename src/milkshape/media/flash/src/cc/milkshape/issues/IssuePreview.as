package cc.milkshape.issues
{
	import cc.milkshape.preloader.PreloaderWiper;
	
	import flash.events.MouseEvent;

	public class IssuePreview extends IssuePreviewClp
	{
		private var _contentClp:IssuePreviewContentClp;
		
		public function IssuePreview(issue:Object = null)
		{
			if(issue)
			{
				addEventListener(MouseEvent.ROLL_OVER, _overHandler);
				addEventListener(MouseEvent.ROLL_OUT, _outHandler);
				over.alpha = 0.7;
				buttonMode = true;
				_contentClp = new IssuePreviewContentClp();
				_contentClp.pastilleClp.stop();
				_contentClp.titleClp.descLabel.text = issue.desc;
				_contentClp.titleClp.titleLabel.text = issue.title;
				_contentClp.infoClp.creatorsLabel.text = issue.nbCreators + ' CREATORS';
				_contentClp.infoClp.squaresLabel.text = issue.nbIssues + ' SQUARES';
				_contentClp.scheduleClp.scheduleLabel.text = issue.schedule;
				_contentClp.pastilleClp.textClp.label.text = '#' + issue.num;
				
				var img:PreloaderWiper = new PreloaderWiper();
				img.loadMedia(issue.url);
				
				_contentClp.loaderClp.addChild(img); 
				content.addChild(_contentClp);
			}	
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