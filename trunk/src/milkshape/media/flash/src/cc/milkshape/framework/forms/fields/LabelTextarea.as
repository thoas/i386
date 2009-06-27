package cc.milkshape.framework.forms.fields
{
	import flash.events.FocusEvent;
	
	public class LabelTextarea extends LabelTextareaClp
	{		
		public function LabelTextarea(label:String = '')
		{
			textarea.stop();
			label.text = label;
			
			textarea.addEventListener(FocusEvent.FOCUS_IN, _focusHandler);
			textarea.addEventListener(FocusEvent.FOCUS_OUT, _blurHandler);
		}
		
		private function _focusHandler(e:FocusEvent):void
		{
			textarea.gotoAndStop('focus');
		}
		
		private function _blurHandler(e:FocusEvent):void
		{
			textarea.gotoAndStop('blur');
		}
		
		public function get text():String
		{
			return label.text;
		}
		
	}	
}