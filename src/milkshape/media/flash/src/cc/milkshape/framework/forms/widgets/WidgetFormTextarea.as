package cc.milkshape.framework.forms.widgets
{
	import com.bourre.plugin.Plugin;
	
	public class WidgetFormTextarea extends WidgetForm
	{
		public function WidgetFormTextarea(owner:Plugin=null, name:String=null)
		{
			super(owner, WidgetFormList.TEXTAREA, name, new TextareaClp());
		}
	}
}