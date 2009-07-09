package cc.milkshape.framework.forms.widgets
{
	import com.bourre.plugin.Plugin;
	
	
	public class WidgetFormSmallButton extends WidgetFormButton
	{
		public function WidgetFormSmallButton(owner:Plugin=null, name:String=null, item:*=null)
		{
			super(owner, WidgetFormList.SMALL_BUTTON + '_' + name, name, new SmallButtonClp(), item);
			with(view as SmallButtonClp)
			{
				over.width = bg.shape.width = Math.round(label.width) + 22;	
			}
		}
	}
}