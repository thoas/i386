package cc.milkshape.framework.forms.fields
{
    import flash.events.FocusEvent;
    public class LabelInput extends LabelInputClp
    {		
        public function LabelInput(labelText:String, password:Boolean = false)
        {
            input.stop();
						
            label.text = labelText;		
			
            if(password)
				input.label.displayAsPassword = true;
            text = '';
            input.addEventListener(FocusEvent.FOCUS_IN, focus);
            input.addEventListener(FocusEvent.FOCUS_OUT, blur);
        }

        public function focus(e:FocusEvent = null):void
        {
            input.gotoAndStop('focus');
        }

        public function blur(e:FocusEvent = null):void
        {			
            input.gotoAndStop('blur');
        }

        public function get text():String
        {
            return input.label.text;
        }

        public function set text(text:String):void
        {
            input.label.text = text;
        }
    }	
}