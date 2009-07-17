package cc.milkshape.navigation.home.view.buttons
{
    import com.bourre.plugin.Plugin;
    import com.bourre.view.AbstractView;

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.text.TextFieldAutoSize;
    public class HomeArtistButtonUI extends AbstractView
    {
        private static var _pair:Boolean = true;
        private var _overStatut:Boolean;
        private var _profile:Object;

        public function HomeArtistButtonUI(profile:Object, owner:Plugin = null, name:String = null)
        {
            super(owner, name, new HomeArtistClp());
            with(view as HomeArtistClp) {
                buttonMode = true;
                stop();
                _overStatut = false;
                _profile = profile;
				
                addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
                addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
                addEventListener(MouseEvent.CLICK, _clickHandler);
				
                artistText.label.autoSize = TextFieldAutoSize.LEFT;
                artistText2.label.autoSize = TextFieldAutoSize.LEFT;
                if(_pair) {
                    artistText.label.text = _profile.user.username;
                    artistText2.label.text = '';
                    over.width = artistText.width;
                } else {
                    artistText2.label.text = _profile.user.username;
                    artistText.label.text = '';
                    over.width = artistText2.width;
                }	
            }
            _pair = !_pair;		
        }

        private function _overHandler(e:MouseEvent):void
        {
            _overStatut = true;
			
            if (!(view as HomeArtistClp).hasEventListener(Event.ENTER_FRAME))
				(view as HomeArtistClp).addEventListener(Event.ENTER_FRAME, _enterFrame);
        }

        private function _outHandler(e:MouseEvent):void
        {
            _overStatut = false;
			
            if (!(view as HomeArtistClp).hasEventListener(Event.ENTER_FRAME))
				(view as HomeArtistClp).addEventListener(Event.ENTER_FRAME, _enterFrame);
        }

        private function _enterFrame(e:Event):void
        {
            if (_overStatut)
				(view as HomeArtistClp).nextFrame();
			else
				(view as HomeArtistClp).prevFrame();
			
            var currentLabel:String = (view as HomeArtistClp).currentLabel;
            if (currentLabel == 'start' || currentLabel == 'end') {
                (view as HomeArtistClp).removeEventListener(Event.ENTER_FRAME, _enterFrame);
            }
        }

        private function _clickHandler(e:MouseEvent):void
        {
            if(_profile.website) {
                navigateToURL(new URLRequest(_profile.website));
            }
        }
    }
}