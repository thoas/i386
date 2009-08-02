package cc.milkshape.framework.forms.widgets
{
    import com.bourre.plugin.Plugin;
    
    import fl.controls.Label;
    
    import flash.text.TextField;    
    import flash.display.DisplayObject;
    import flash.events.FocusEvent;
    public class WidgetFormText extends WidgetForm
    {
        protected var _label:String; 

        public function WidgetFormText(owner:Plugin = null, name:String = null, label:String = null, mc:DisplayObject = null)
        {
            super(owner, name + '_' + label, mc);
            _label = label;
            with(view as Object) {
                TextField(label).text = _label;
                stop();
                addEventListener(FocusEvent.FOCUS_IN, focus);
                addEventListener(FocusEvent.FOCUS_OUT, blur);
            }
        }

        public function focus(e:FocusEvent = null):void
        {   
            with(view as Object)
            {
                if(TextField(label).text == _label)
                    TextField(label).text = '';
                
                gotoAndStop('focus');   
            }
        }

        public function blur(e:FocusEvent = null):void
        {
            with(view as Object) {
                if(!TextField(label).text.length) {
                    TextField(label).text = _label;
                }
                gotoAndStop('blur');
            }   
        }
    }
}