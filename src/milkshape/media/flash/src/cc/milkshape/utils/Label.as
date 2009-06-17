package cc.milkshape.utils
{
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;

	public class Label extends Sprite
	{
		private var _clip:*;
		public function Label(clip:*, str:String, clr:int = 0x000000)
		{
			_clip = clip;
			_clip.label.autoSize = TextFieldAutoSize.LEFT;
			_clip.label.text = str;
			_clip.label.textColor = clr;
			_clip.over.width = Math.round(_clip.label.width);
			
			addChild(_clip);
		}
		
		public function set text(text:String):void
		{
			_clip.label.text = text;
		}
		
		public function get text():String
		{
			return _clip.label.text;
		}
	}
}