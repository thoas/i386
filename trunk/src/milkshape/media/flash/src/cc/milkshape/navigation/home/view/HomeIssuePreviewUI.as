package cc.milkshape.navigation.home.view
{
    import cc.milkshape.navigation.generic.view.PreviewUI;
    import cc.milkshape.preloader.PreloaderWiper;

    import com.bourre.plugin.Plugin;

    import flash.events.Event;
    import flash.events.MouseEvent;
    public class HomeIssuePreviewUI extends PreviewUI
    {
        private var _overStatut:Boolean;

        public function HomeIssuePreviewUI(issue:Object, owner:Plugin = null, name:String = null):void
        {
            super(owner, name, new HomeIssuePreviewClp());
            _issue = issue;
            _overStatut = false;
            
			if(issue.thumb_url)
				_thumbUrl = issue.thumb_url;
            var img:PreloaderWiper = new PreloaderWiper();
            
            with(view as HomeIssuePreviewClp) {
                buttonMode = true;
                stop();
                
                titleClp.label.text = issue.title;
                infoClp.label.htmlText = issue.text_presentation;
                img.loadMedia(_thumbUrl);
                bg.addChild(img);
            }
        }

        override protected function _overHandler(e:MouseEvent):void
        {
            _overStatut = true;
            
            if (view && !(view as HomeIssuePreviewClp).hasEventListener(Event.ENTER_FRAME))
                (view as HomeIssuePreviewClp).addEventListener(Event.ENTER_FRAME, _enterFrameHandler);
        }

        override protected function _outHandler(e:MouseEvent):void
        {
            _overStatut = false;
            
            if (view && !(view as HomeIssuePreviewClp).hasEventListener(Event.ENTER_FRAME))
                (view as HomeIssuePreviewClp).addEventListener(Event.ENTER_FRAME, _enterFrameHandler);
        }

        private function _enterFrameHandler(e:Event):void
        {
            if (_overStatut)
                (view as HomeIssuePreviewClp).nextFrame();
            else
                (view as HomeIssuePreviewClp).prevFrame();
            
            var currentLabel:String = (view as HomeIssuePreviewClp).currentLabel;
            if (currentLabel == 'start' || currentLabel == 'end') {
                (view as HomeIssuePreviewClp).removeEventListener(Event.ENTER_FRAME, _enterFrameHandler);
            }
        }
    }
}