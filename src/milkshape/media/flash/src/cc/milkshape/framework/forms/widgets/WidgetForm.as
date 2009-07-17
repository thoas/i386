package cc.milkshape.framework.forms.widgets
{
    import com.bourre.plugin.Plugin;
    import com.bourre.view.AbstractView;

    import flash.display.DisplayObject;
    public class WidgetForm extends AbstractView
    {
        public function WidgetForm(owner:Plugin = null, name:String = null, mc:DisplayObject = null)
        {
            super(owner, name, mc);
        }
    }
}