package grid.square
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class SquareFull extends Square
	{
		private var _currentSize:int;
		private var _container:Sprite;
		private var _lstImage:Vector.<Bitmap>;
		private var _url:String;
		private var _loader:Loader;
		private var _scaleThumb:Array = new Array(25, 50, 100, 200, 400, 800);
		
		public function SquareFull(x:int, y:int, url:String, w:int = Square.SQUARE_WIDTH, h:int = Square.SQUARE_HEIGHT)
		{
			_lstImage = new Vector.<Bitmap>(_scaleThumb.length);
			_url = url;
			super(x, y, 0x000000, w, h);
			
			_container = new Sprite();
			
			addChild(_container);
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            
            _currentSize = 0;
            _loadImage();
            _currentSize = 5;
            _loadImage();
		}
		
		private function _loadImage():void
		{
            _loader.load(new URLRequest("img/"+_url+"_"+_scaleThumb[_currentSize]+".jpg"));
		}
		
		private function completeHandler(event:Event):void
		{
			_lstImage[_currentSize] = Bitmap(_loader.content);
			_container.addChild(_lstImage[_currentSize]);
			_container.width = SQUARE_WIDTH;
			_container.height = SQUARE_HEIGHT;
        }

		private function ioErrorHandler(event:IOErrorEvent):void
		{
            trace("Unable to load image: " + _url);
        }

	}
}