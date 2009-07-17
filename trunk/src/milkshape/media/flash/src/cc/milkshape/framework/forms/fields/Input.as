package cc.milkshape.framework.forms.fields
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
			
            addEventListener(FocusEvent.FOCUS_IN, focus);
            addEventListener(FocusEvent.FOCUS_OUT, blur);
        }

        public function focus(e:FocusEvent = null):void
        {			
            if(_password)
				label.displayAsPassword = true;
				
            if(label.text == _defautText)
				label.text = '';
			
            gotoAndStop('focus');
        }

        public function get text():String
        {
            return label.text;
        }

        public function blur(e:FocusEvent = null):void
        {
            if(label.text == '') {
                label.text = _defautText;
                label.displayAsPassword = false;
            }
				
            gotoAndStop('blur');
        }
    }	
}