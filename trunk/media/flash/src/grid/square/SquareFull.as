package grid.square
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import grid.GridModel;
	import grid.GridZoomEvent;
	
	public class SquareFull extends Square
	{
		private var _currentSize:int;
		private var _lstImage:Vector.<Bitmap>;
		private var _url:String;
		private var _loader:Loader;
		private var _scaleThumb:Array = new Array(25, 50, 100, 200, 400, 800);
		private var _size:int;
		
		public function SquareFull(x:int, y:int, url:String, gridModel:GridModel, size:int)
		{
			super(x, y, 0x000000, size);
			_url = url;
			_size = size;
			
			_lstImage = new Vector.<Bitmap>(_scaleThumb.length);
			
			_loader = new Loader();// Un seul loader... donc un seul téléchargement possible à la fois
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
            
            gridModel.addEventListener(GridZoomEvent.ZOOM, _loadImage);           
		}
		
		private function _loadImage(e:GridZoomEvent):void
		{
			var scale:int = e.currentScale;
			
			if(_lstImage[scale] == null)// si l'image n'est pas déjà chargé
			{
            	_loader.load(new URLRequest("img/"+_url+"_"+_scaleThumb[scale]+".jpg"));
   			}
   			else
   			{
   				removeChild(_lstImage[_currentSize]);
   				_currentSize = scale;
   				addChild(_lstImage[_currentSize]);
   			}
		}
		
		private function _completeHandler(e:Event):void
		{
			// Par la largeur de l'image chargé on retrouve l'échelle actuelle
			// Celà permet de s'assurer que l'échelle actuelle et l'image chargée et à afficher correspondent
			var o:LoaderInfo = LoaderInfo(e.target);
			var scale:int = _scaleThumb.indexOf(o.width);
			_currentSize = scale < 0 ? 0 : scale;
			
			var bitmap:Bitmap = Bitmap(o.content);
			bitmap.width = bitmap.height = _size;
			
			_lstImage[_currentSize] = bitmap;
			addChild(_lstImage[_currentSize]);
        }

		private function _ioErrorHandler(event:IOErrorEvent):void
		{
            trace('Unable to load image : ' + _url);
        }

	}
}