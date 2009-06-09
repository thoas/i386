package cc.milkshape.preloader
{
	import com.gskinner.motion.GTween;
	import fl.motion.easing.Cubic;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class PreloaderKb extends Preloader
	{
		private var _label:TextField;
		
		override protected function _init():void
		{
			addChild(_loader);
			_loader.alpha = 0;

			var format:TextFormat = new TextFormat();
            format.font = new VerdanaRegular().fontName;
            format.color = 0xFFFFFF;
            format.size = 12;
            
            _label = new TextField();
			_label.selectable = false;
            _label.defaultTextFormat = format;
            _label.text = "Milkshape";
            _label.embedFonts = true;
            
            _label.x = stage.stageWidth / 2;
            _label.y = stage.stageHeight / 2;
            
            addChild(_label);
		}
		
		override protected function _onProgress():void
        {
			_label.text = String(Math.round(_bytesLoaded / 1000)) + " / " + String(Math.round(_bytesTotal / 1000)) + " Kb";
        }
        
        override protected function _close():void
        {
        	new GTween(_label, 1, { alpha: 0 }, { ease:Cubic.easeOut });
        	new GTween(_loader, 2, { alpha: 1 }, { ease:Cubic.easeOut });
        }
        
	}
}