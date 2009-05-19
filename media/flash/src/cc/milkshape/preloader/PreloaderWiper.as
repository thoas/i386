package cc.milkshape.preloader
{
	import cc.milkshape.utils.Calcul;
	import com.gskinner.motion.GTween;	
	import fl.motion.easing.Cubic;	
	import flash.events.Event;
	
	public class PreloaderWiper extends Preloader
	{
		private var _range:Number;
		private var _hazard:Number;
		private var _color:int;
		
		public function PreloaderWiper(url:String, msg:String = "", color:int = 0x000000)
		{
			super(url, msg);
			_range = 15;
			_color = color;
		}
		
		override protected function _init():void
		{
			addChild(_loader);
			_loader.alpha = 0;
			
			addChild(_sprite);
			_sprite.graphics.beginFill(_color);
            _sprite.graphics.drawRect(0, 0, 1, stage.stageHeight);
            _sprite.graphics.endFill();
		}
		
		override protected function _onProgress(p:int):void
        {
			_hazard = _hazard ? _hazard : cc.milkshape.utils.Calcul.randRange(p, p + _range);// Initialisation
			if(p == _hazard && _hazard != 100)
			{
				_hazard = cc.milkshape.utils.Calcul.randRange(_hazard + 1, _hazard + _range);
				if (_hazard > 100) _hazard = 100;
				height = stage.stageHeight;
				new GTween(_sprite, 1, { width: stage.stageWidth * (_hazard / 100) }, { ease:Cubic.easeOut });
			}
        }
        
        override protected function _close():void
        {
        	new GTween(_sprite, 1, { width: stage.stageWidth }, { ease:Cubic.easeOut, completeListener: _completeHandlerFunction });
        }
        
        private function _completeHandlerFunction(e:Event):void
        {
        	_loader.alpha = 1;
        	new GTween(_sprite, 1, { width: 0 }, { ease:Cubic.easeOut });
        }
        
	}
}