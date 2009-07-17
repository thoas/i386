package cc.milkshape.framework.forms.error
{
    public class WidgetException extends Error
    {
        public static const WIDGET_NOT_FOUND:String = 'Widget {{__name__}} not found';

        public function WidgetException(message:*=  "", id:*=  0)
        {
            super(message, id);
        }
    }
}