package cc.milkshape.framework.forms.widgets
{
	import com.bourre.plugin.Plugin;
	
	import flash.events.FocusEvent;
	
	public class WidgetFormInput extends WidgetFormText
	{
		private var _password:Boolean;
		public function WidgetFormInput(owner:Plugin=null, name:String=null, password:Boolean=false)
		{
			super(owner, WidgetFormList.INPUT, name, new InputClp());
			_password = password;
		}
		
		override public function focus(e:FocusEvent = null):void
		{
			super.focus(e);
			if(_password)
				(view as InputClp).label.displayAsPassword = true;
		}
		
		public function get text():String
		{
			return (view as InputClp).label.text;
		}
	
		override public function blur(e:FocusEvent = null):void
		{
			super.blur(e);
			if(!(view as InputClp).label.text.length)
				(view as InputClp).label.displayAsPassword = false;
		}
	}
}