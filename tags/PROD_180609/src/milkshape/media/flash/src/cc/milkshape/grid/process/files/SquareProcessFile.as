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
    
	public class SquareProcessFile extends FileReference
	{
		private var _request:URLRequest;
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

		public function downloadTpl(request:URLRequest = null, defaultFileName:String=null) : void
		{
			if(request == null)
				request = _request;
			download(_request, defaultFileName);
		}
		
		public function browseTpl(typeFilter:Array=null) : Boolean
		{
			return browse(_getTypes());
		}
		
        private function _configureListeners():void 
        {
            addEventListener(Event.CANCEL, _cancelHandler);
            addEventListener(Event.COMPLETE, _completeHandler);
            addEventListener(HTTPStatusEvent.HTTP_STATUS, _httpStatusHandler);
            addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
            addEventListener(Event.OPEN, _openHandler);
            addEventListener(ProgressEvent.PROGRESS, _progressHandler);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, _securityErrorHandler);
            addEventListener(Event.SELECT, _selectHandler);
            addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, _uploadCompleteDataHandler);
        }

        private function _getTypes():Array {
            var allTypes:Array = new Array(_getImageTypeFilter(), _getTextTypeFilter());
            return allTypes;
        }

        private function _getImageTypeFilter():FileFilter {
            return new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)", "*.jpg;*.jpeg;*.gif;*.png");
        }

        private function _getTextTypeFilter():FileFilter {
            return new FileFilter("Text Files (*.txt, *.rtf)", "*.txt;*.rtf");
        }

        private function _cancelHandler(event:Event):void {
            trace("cancelHandler: " + event);
        }

        private function _completeHandler(event:Event):void {
            trace("completeHandler: " + event);
        }

        private function _uploadCompleteDataHandler(event:DataEvent):void {
            trace("uploadCompleteData: " + event);
        }

        private function _httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }
        
        private function _ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
        }

        private function _openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function _progressHandler(event:ProgressEvent):void {
            var file:FileReference = FileReference(event.target);
            trace("progressHandler name=" + file.name + " bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        private function _securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }

        private function _selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
            file.upload(_request);
        }

	}
}