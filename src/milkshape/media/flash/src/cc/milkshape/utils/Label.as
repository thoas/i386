package cc.milkshape.utils
{
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;

	public class Label extends Sprite
	{
		public function Label(clip:*, str:String, clr:int = 0x000000)
		{
			clip.label.autoSize = TextFieldAutoSize.LEFT;
			clip.label.text = str;
			clip.label.textColor = clr;
			clip.over.width = Math.round(clip.label.width);
			
			addChild(clip);
		}
	}
}