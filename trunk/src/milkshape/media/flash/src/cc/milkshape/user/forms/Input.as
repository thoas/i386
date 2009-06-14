package cc.milkshape.user.forms
{
	import flash.events.FocusEvent;
	
	public class Input extends InputClp
	{
		private var _password:Boolean;
		private var _defautText:String; 
		
		public function Input(defautText:String = '', password:Boolean = false)
		{
			_defautText = defautText;
			_password = password;
			stop();
			label.text = defautText;
			
			addEventListener(FocusEvent.FOCUS_IN, _focusHandler);
			addEventListener(FocusEvent.FOCUS_OUT, _blurHandler);
		}
		
		private function _focusHandler(e:FocusEvent):void
		{
			if(_password)
				label.displayAsPassword = true;
				
			if(label.text == _defautText)
				label.text = '';
			
			gotoAndStop('focus');
		}
	
		private function _blurHandler(e:FocusEvent):void
		{
			if(label.text == '')
			{
				label.text = _defautText;
				label.displayAsPassword = false;
			}
				
			gotoAndStop('blur');
		}
		
	}	
}