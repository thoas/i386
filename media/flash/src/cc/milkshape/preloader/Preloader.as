package cc.milkshape.preloader
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class Preloader extends Sprite
	{
		private var _url:String;
		private var _msg:*;
		protected var _sprite:Sprite;
		protected var _loader:Loader;
		
		public function Preloader(url:String, msg:*)
		{
			_url = url;
			_msg = msg;
            addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, _openHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _progressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
            _loader.load(new URLRequest(_url));
            
            _sprite = new Sprite();
		}
        
        private function _progressHandler(e:ProgressEvent):void
		{
			if(e.bytesLoaded != e.bytesTotal) _onProgress(Math.round(e.bytesLoaded * 100 / e.bytesTotal));
		}
		
		private function _openHandler(e:Event):void { _init(); }
		
		private function _completeHandler(e:Event):void 
		{
			e.target.sharedEvents.dispatchEvent(new PreloaderEvent(PreloaderEvent.INFO, _msg));// Passage de variable
			_close();
		}
		
		private function _ioErrorHandler(event:IOErrorEvent):void { trace('Unable to load image'); }
		
		protected function _init():void	{ }
        protected function _close():void { }
        protected function _onProgress(p:int):void { }
        
	}
}