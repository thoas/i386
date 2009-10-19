package cc.milkshape.navigation.issue.view
{
    import cc.milkshape.navigation.generic.view.PreviewUI;
    import cc.milkshape.preloader.PreloaderWiper;

    import com.bourre.plugin.Plugin;

    import flash.events.MouseEvent;
    public class IssuePreviewUI extends PreviewUI
    {
        public function IssuePreviewUI(issue:Object, owner:Plugin = null, name:String = null)
        {
            super(owner, name, new IssuePreviewClp());
			if(issue.thumb_url)
				_thumbUrl = issue.thumb_url;
			
            var img:PreloaderWiper = new PreloaderWiper();
            _issue = issue;
            with(view as IssuePreviewClp) {
                over.alpha = 0.7;
                buttonMode = true;
                pastilleClp.stop();
                titleClp.descLabel.htmlText = issue.text_presentation ;
                titleClp.titleLabel.text = issue.title;
                infoClp.creatorsLabel.text = issue.nb_creators + ' CREATORS';
                infoClp.squaresLabel.text = issue.nb_case_x * issue.nb_case_y + ' SQUARES';
                scheduleClp.scheduleLabel.text = 'OPENED ' + issue.date_created.month + '.' + issue.date_created.date + '.' + issue.date_created.fullYear;
                pastilleClp.textClp.label.text = '#' + issue.id;
                
                img.loadMedia(_thumbUrl);
                loaderClp.addChild(img);
            }
        }

        override protected function _overHandler(e:MouseEvent):void
        {
            if(view)
                (view as IssuePreviewClp).over.alpha = 0;
        }

        override protected function _outHandler(e:MouseEvent):void
        {
            if(view)
                (view as IssuePreviewClp).over.alpha = 0.7;
        }
    }
}