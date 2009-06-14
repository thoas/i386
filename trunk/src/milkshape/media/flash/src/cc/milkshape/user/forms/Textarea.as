package cc.milkshape.user.forms
{
	import flash.events.FocusEvent;
	
	public class Textarea extends TextareaClp
	{
		private var _defautText:String; 
		
		public function Textarea(defautText:String = '')
		{
			_defautText = defautText;
			stop();
			label.text = _defautText;
			
			addEventListener(FocusEvent.FOCUS_IN, _focusHandler);
			addEventListener(FocusEvent.FOCUS_OUT, _blurHandler);
		}
		
		private function _focusHandler(e:FocusEvent):void
		{
			if(label.text == _defautText)
				label.text = '';
				
			gotoAndStop('focus');
		}
		
		private function _blurHandler(e:FocusEvent):void
		{
			if(label.text == '')
				label.text = _defautText;
				
			gotoAndStop('blur');
		}
	}	
}