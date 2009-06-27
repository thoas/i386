package
{
	import com.reintroducing.ui.AxisScroller;
	import fl.motion.easing.Sine;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Terms extends Sprite
	{
		public function Terms()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			var terms:TermsClp = new TermsClp();
			addChild(terms);
			
			var optionalObj:Object = {
				scrollType: "easing", 
				isTrackClickable: true, 
				continuousScroll: false,
				easeFunc: Sine.easeOut, 
				duration: .25,
				scaleScroller: true,
				autoHideControls: true
			};

			var scroller:AxisScroller = new AxisScroller(stage, terms.content_mc, terms.content_mc.scroller_mc, terms.content_mc.movie_mc, terms.content_mc.track_mc, terms.content_mc.mask_mc, "y", optionalObj);
		}
	}
}