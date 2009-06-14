package cc.milkshape.user.forms
{
	import flash.events.FocusEvent;
	
	public class Textarea extends TextareaClp
	{
		public function Textarea()
		{
			stop();
			label.text = '';
			
			addEventListener(FocusEvent.FOCUS_IN, _focusHandler);
			addEventListener(FocusEvent.FOCUS_OUT, _blurHandler);
		}
	}
	
	private function _focusHandler(e:FocusEvent):void
	{
		gotoAndStop('focus');
	}
	
	private function _blurHandler(e:FocusEvent):void
	{
		gotoAndStop('blur');
	}
}