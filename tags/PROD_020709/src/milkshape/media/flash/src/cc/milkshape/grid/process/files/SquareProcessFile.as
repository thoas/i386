package cc.milkshape.grid.process.files
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLVariables;

	public class SquareProcessFile extends FileReference
	{
		protected var _request:URLRequest;
		public function SquareProcessFile(URI:String = null)
		{
			super();
			if(URI != null)
				setURI(URI);
			_configureListeners();
		}

		public function getURI():String
		{
			return _request.url;
		}

		public function setURI(v:String):void
		{
			_request = new URLRequest();
			_request.url = v;
		}

		public function get request():URLRequest
		{
			return _request;
		}

		public function set request(v:URLRequest):void
		{
			_request = v;
		}
		
        protected function _configureListeners():void 
        {
            addEventListener(Event.CANCEL, _cancelHandler);
            addEventListener(HTTPStatusEvent.HTTP_STATUS, _httpStatusHandler);
            addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
            addEventListener(Event.OPEN, _openHandler);
            addEventListener(ProgressEvent.PROGRESS, _progressHandler);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);
            addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, _uploadCompleteDataHandler);
        }

        protected function _getTypes():Array {
            var allTypes:Array = new Array(_getImageTypeFilter());
            return allTypes;
        }

        protected function _getImageTypeFilter():FileFilter {
            return new FileFilter("Images (*.tiff, *.tif)", "*.tif;*.tiff");
        }

        protected function _cancelHandler(event:Event):void {
            trace("cancelHandler: " + event);
        }

        protected function _uploadCompleteDataHandler(event:DataEvent):void {
            trace("uploadCompleteData: " + event);
        }

        protected function _httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }
        
        protected function _ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        protected function _openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        protected function _progressHandler(event:ProgressEvent):void {
            var file:FileReference = FileReference(event.target);
            trace("progressHandler name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        protected function _securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
	}
}