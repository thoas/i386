package cc.milkshape.grid.layer.events
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class LayerEvent extends Event
	{
		public static const LAYER_LOADED:String = 'LAYER_LOADED';
		
		private var _thumb:Bitmap;
		private var _posX:int;
		private var _posY:int;
		private var _currentStep:int;
		private var _currentScale:int;
		public function LayerEvent(type:String, thumb:Bitmap, posX:int, posY:int, currentScale:int, currentStep:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_thumb = thumb;
			_posX = posX;
			_posY = posY;
			_currentScale = currentScale;
			_currentStep = currentStep;
			super(type, bubbles, cancelable);
		}

		public function get currentScale():int
		{
			return _currentScale;
		}

		public function set currentScale(v:int):void
		{
			_currentScale = v;
		}

		public function get currentStep():int
		{
			return _currentStep;
		}

		public function set currentStep(v:int):void
		{
			_currentStep = v;
		}

		public function get posY():int
		{
			return _posY;
		}

		public function set posY(v:int):void
		{
			_posY = v;
		}

		public function get posX():int
		{
			return _posX;
		}

		public function set posX(v:int):void
		{
			_posX = v;
		}

		public function get thumb():Bitmap
		{
			return _thumb;
		}

		public function set thumb(v:Bitmap):void
		{
			_thumb = v;
		}

	}
}