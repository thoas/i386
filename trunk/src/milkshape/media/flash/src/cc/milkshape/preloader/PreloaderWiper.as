package cc.milkshape.preloader
{
	import cc.milkshape.utils.Calcul;
	import com.gskinner.motion.GTween;	
	import fl.motion.easing.Cubic;	
	import flash.display.MovieClip;
	import flash.events.Event;	
	
	public class PreloaderWiper extends Preloader
	{
		private var _range:Number;
		private var _hazard:Number;
		private var _color:int;
		private var _mc:MovieClip;
		
		public function PreloaderWiper(color:int = 0x000000)
		{
			_color = color;
		}
		
		override protected function _init():void
		{
			addChild(_loader);
			_loader.alpha = 0;
			
			_mc = new MovieClip();
			_mc.graphics.beginFill(_color);
            _mc.graphics.drawRect(0, 0, 1, stage.stageHeight);
            _mc.graphics.endFill();
            addChild(_mc);
		}
		
		override protected function _onProgress():void
        {
			_hazard = _hazard ? _hazard : cc.milkshape.utils.Calcul.randRange(_percent, _percent + _range);// Initialisation
			if(_percent == _hazard && _hazard != 100)
			{
				_hazard = cc.milkshape.utils.Calcul.randRange(_hazard + 1, _hazard + _range);
				if (_hazard > 100) _hazard = 100;
				height = stage.stageHeight;
				new GTween(_mc, 1, { width: stage.stageWidth * (_hazard / 100) }, { ease:Cubic.easeOut });
			}
        }
        
        override protected function _close():void
        {
        	new GTween(_mc, 1, { width: stage.stageWidth }, { ease:Cubic.easeOut, completeListener: _completeHandlerFunction });
        }
        
        private function _completeHandlerFunction(e:Event):void
        {
        	_loader.alpha = 1;
        	new GTween(_mc, 1, { width: 0 }, { ease:Cubic.easeOut });
        }
        
	}
}