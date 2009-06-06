package cc.milkshape.framework.forms
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.refunk.events.TimelineEvent;
    import com.refunk.timeline.TimelineWatcher;
    import cc.milkshape.manager.KeyboardManager;
	
	public class LoginForm extends LoginFormClip
	{
		
		public function LoginForm()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			loginBtn.buttonMode = true;
			loginBtn.addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			KeyboardManager.enabled = false;
			gotoAndStop('form');
			//addEventListener(MouseEvent.CLICK, _clickHandler);
			loginForm.password.displayAsPassword = true;
			loginForm.submit.buttonMode = true;
			loginForm.submit.addEventListener(MouseEvent.CLICK, _submit);
        }
		
		private function _submit(e:MouseEvent):void
		{
			trace(loginForm.login.txt.text + " " + loginForm.password.txt.text); 
		}
		
	}
}