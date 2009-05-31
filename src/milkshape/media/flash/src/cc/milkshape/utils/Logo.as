package cc.milkshape.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Logo extends Sprite
	{
		public var _label:TextField;
		
		public function Logo()
		{
			_label = new TextField();
			_label.selectable = false;

            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFFFFFF;
            format.size = 12;

            _label.defaultTextFormat = format;
            _label.text = "Milkshape";			
			addChild(_label);
		}
		
	}
}