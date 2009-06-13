package cc.milkshape.preloader
{
	import cc.milkshape.preloader.events.PreloaderEvent;
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
		protected var _loader:Loader;
		protected var _bytesTotal:int;
		protected var _bytesLoaded:int;
		protected var _percent:int;
		
		public function Preloader()
		{
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, _openHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, _progressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
		}
		
		public function unloadMedia():void
		{
			_loader.unload();
		}
		
		public function loadMedia(url:String):void
		{
			_url = url;
			_loader.load(new URLRequest(url));
		}
		
        private function _progressHandler(e:ProgressEvent):void
		{
			_bytesTotal = e.bytesTotal;
			_bytesLoaded = e.bytesLoaded;
			_percent = Math.round(_bytesLoaded * 100 / _bytesTotal);
				
			if(_bytesLoaded != _bytesTotal) _onProgress(); 
		}
		
		private function _openHandler(e:Event):void { _init(); }
		
		private function _completeHandler(e:Event):void 
		{
			e.target.sharedEvents.dispatchEvent(new PreloaderEvent(PreloaderEvent.INFO, _msg));// Passage de variable
			_close();
		}
		
		private function _ioErrorHandler(e:IOErrorEvent):void { 
			throw new Error('Unable to load ' + _url); 
		}
		
		protected function _init():void	{ }
        protected function _close():void { }
        protected function _onProgress():void { }
        
	}
}