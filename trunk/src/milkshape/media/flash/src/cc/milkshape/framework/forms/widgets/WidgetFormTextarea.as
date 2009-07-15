package cc.milkshape.framework.forms.widgets
{
	import com.bourre.plugin.Plugin;
	
	public class WidgetFormTextarea extends WidgetFormText
	{
		public function WidgetFormTextarea(owner:Plugin=null, name:String=null)
		{
			super(owner, WidgetFormList.TEXTAREA, name, new TextareaClp());
		}
		
		public function get text():String
		{
			return (view as TextareaClp).label.text;
		}
	}
}