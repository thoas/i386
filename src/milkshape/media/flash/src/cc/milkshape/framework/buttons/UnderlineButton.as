package cc.milkshape.framework.buttons
{
	import flash.text.TextFieldAutoSize;
	
	public class UnderlineButton extends UnderlineButtonClp
	{
		public function UnderlineButton(labelText:String)
		{
			buttonMode = true;
			label.autoSize = TextFieldAutoSize.LEFT;
			label.text = labelText.toUpperCase();
			line.width = label.width - 8;
			over.width = line.width;
		}
	}
}