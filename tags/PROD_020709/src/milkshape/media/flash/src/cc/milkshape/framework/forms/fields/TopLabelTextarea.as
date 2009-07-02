package cc.milkshape.framework.forms.fields
{
	import flash.events.FocusEvent;
	
	public class TopLabelTextarea extends TopLabelTextareaClp
	{		
		public function TopLabelTextarea(labelText:String = '')
		{
			textarea.stop();
			label.text = labelText;
			
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