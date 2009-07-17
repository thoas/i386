package cc.milkshape.framework.forms.widgets
{
    import com.bourre.collection.HashMap;
    
    public class WidgetFormSchema extends HashMap
    {
        private var _view:*;
        public function WidgetFormSchema(widgets:Object = null, view:* = null)
        {
            _view = view;
            if(widgets)
            {
                for(var keyWidget:String in widgets)
                {
                    put(keyWidget, widgets[keyWidget]);
                    view[keyWidget].addChild((widgets[keyWidget] as WidgetForm).view);
                }   
            }
        }
    }
}