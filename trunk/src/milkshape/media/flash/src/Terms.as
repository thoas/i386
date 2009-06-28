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
			
			var scrollItems:ScrollItemsClp = new ScrollItemsClp();
			scrollItems.track.height = terms.scrollArea.bg.height - 2;
			terms.scrollArea.scroll.addChild(scrollItems);
			var scroller:AxisScroller = new AxisScroller(stage, terms.scrollArea, scrollItems.scroller, terms.scrollArea.content, scrollItems.track, terms.scrollArea.mask, "y", optionalObj);
		}
	}
}