package cc.milkshape.utils
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.refunk.events.TimelineEvent;
    import com.refunk.timeline.TimelineWatcher;
    import cc.milkshape.manager.KeyboardManager;
	
	public class LoginForm extends LoginFormClip
	{
		private var _timelineWatcher:TimelineWatcher;
		
		public function LoginForm()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			LoginBtn.buttonMode = true;
			LoginBtn.addEventListener(MouseEvent.CLICK, _clickHandler);
			addEventListener(MouseEvent.CLICK, _clickHandler);
			
			_timelineWatcher = new TimelineWatcher(this);
            _timelineWatcher.addEventListener(TimelineEvent.LABEL_REACHED, _handleTimelineEvent);

			LoginForm.PasswordInput.displayAsPassword = true;
			LoginForm.SubmitBtn.addEventListener(MouseEvent.CLICK, _submit);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			KeyboardManager.enabled = false;
			gotoAndStop('form');
        }
 
        private function _handleTimelineEvent(e:TimelineEvent):void
        {
        	trace(e.currentLabel);
		}
		
		private function _submit(e:MouseEvent):void
		{
			trace(LoginForm.LoginInput.text + " " + LoginForm.PasswordInput.text); 
		}
		
	}
}