package cc.milkshape.utils
{
	import flash.text.TextFormat;
	
	public class MilkshapeTextFormat
	{
		public static function H1():TextFormat
		{
			var format:TextFormat = new TextFormat();
            format.font = new VerdanaRegular().fontName;
            format.color = 0xFFFFFF;
            format.size = 14;
            format.bold = true;
            return format;
		}
		
		public static function H2():TextFormat
		{
			var format:TextFormat = new TextFormat();
            format.font = new HelveticaLTStdFt().fontName;
            format.color = 0x000000;
            format.size = 14;
            return format;
		}

	}
}