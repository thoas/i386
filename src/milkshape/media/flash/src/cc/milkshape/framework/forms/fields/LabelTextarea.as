package cc.milkshape.framework.forms.fields
{
    import flash.events.FocusEvent;
    public class LabelTextarea extends LabelTextareaClp
    {		
        public function LabelTextarea(labelText:String = '')
        {
            textarea.stop();
            label.text = labelText;
			
            textarea.addEventListener(FocusEvent.FOCUS_IN, focus);
            textarea.addEventListener(FocusEvent.FOCUS_OUT, blur);
        }

        public function focus(e:FocusEvent = null):void
        {
            textarea.gotoAndStop('focus');
        }

        public function blur(e:FocusEvent = null):void
        {
            textarea.gotoAndStop('blur');
        }

        public function get text():String
        {
            return textarea.label.text;
        }
    }	
}