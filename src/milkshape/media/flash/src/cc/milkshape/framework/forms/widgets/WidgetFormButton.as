package cc.milkshape.framework.forms.widgets
{
    import com.bourre.plugin.Plugin;
    
    import flash.text.TextField;
    
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;
    public class WidgetFormButton extends WidgetForm
    {
        private var _item:*;
        private var _label:String;
        private var _overStatus:Boolean;

        public function WidgetFormButton(owner:Plugin = null, name:String = null, label:String = null, mc:DisplayObject = null, item:* =  null)
        {
            super(owner, name, mc);
            _item = item;
            _overStatus = false;
            _label = label;
            
            with(view as Object) {
                item.addChild(_item);
                
                buttonMode = true;
                stop();
                _item.stop();
                
                addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
                addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
                
                TextField(label).autoSize = TextFieldAutoSize.LEFT;
                TextField(label).text = _label; 
            }
        }

        protected function _overHandler(e:MouseEvent):void
        {
            _overStatus = true;
            
            if (!(view as MovieClip).hasEventListener(Event.ENTER_FRAME))
                (view as MovieClip).addEventListener(Event.ENTER_FRAME, _enterFrameHandler);
        }

        protected function _outHandler(e:MouseEvent):void
        {
            _overStatus = false;
            
            if (!(view as MovieClip).hasEventListener(Event.ENTER_FRAME))
                (view as MovieClip).addEventListener(Event.ENTER_FRAME, _enterFrameHandler);
        }

        protected function _enterFrameHandler(e:Event):void
        {
            if (_overStatus) {
                (view as MovieClip).nextFrame();
                _item.nextFrame();
            } else {
                (view as MovieClip).prevFrame();
                _item.prevFrame();
            }
            var currentLabel:String = (view as MovieClip).currentLabel;
            if (currentLabel == 'start' || currentLabel == 'end') {
                (view as MovieClip).removeEventListener(Event.ENTER_FRAME, _enterFrameHandler);
            }
        }
    }
}