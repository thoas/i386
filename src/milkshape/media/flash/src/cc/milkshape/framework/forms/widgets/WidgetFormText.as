package cc.milkshape.framework.forms.widgets
{
    import com.bourre.plugin.Plugin;

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
                Label(label).text = _label;
                stop();
                addEventListener(FocusEvent.FOCUS_IN, focus);
                addEventListener(FocusEvent.FOCUS_OUT, blur);
            }
        }

        public function focus(e:FocusEvent = null):void
        {   
            with(view as Object)
            {
                if(Label(label).text == _label)
                    Label(label).text = '';
                
                gotoAndStop('focus');   
            }
        }

        public function blur(e:FocusEvent = null):void
        {
            with(view as Object) {
                if(!label.text.length) {
                    label.text = _label;
                }
                gotoAndStop('blur');
            }   
        }
    }
}