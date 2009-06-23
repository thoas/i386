package cc.milkshape.framework.forms.fields
{
	import flash.events.FocusEvent;
	
	public class Input extends TopLabelInputClp
	{		
		public function Input(label:String, password:Boolean = false)
		{
			input.stop();
						
			label.text = label;		
			
			if(password)
				input.label.displayAsPassword = true;
				
			input.addEventListener(FocusEvent.FOCUS_IN, focus);
			input.addEventListener(FocusEvent.FOCUS_OUT, blur);
		}
		
		public function focus(e:FocusEvent = null):void
		{
			input.gotoAndStop('focus');
		}
	
		public function blur(e:FocusEvent = null):void
		{			
			input.gotoAndStop('blur');
		}
		
		public function get text():String
		{
			return input.label.text;
		}
		
	}	
}