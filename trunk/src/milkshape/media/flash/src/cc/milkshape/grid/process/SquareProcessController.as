package cc.milkshape.grid.process
{
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.grid.GridModel;
	import cc.milkshape.grid.process.events.SquareProcessEvent;
	import cc.milkshape.grid.process.files.SquareProcessFileDownload;
	import cc.milkshape.grid.process.files.SquareProcessFileUpload;
	
	import flash.events.Event;
	import flash.net.Responder;
	import flash.utils.ByteArray;

	public class SquareProcessController extends GatewayController
	{
		private var _gridModel:GridModel;
		private var _fileDownload:SquareProcessFileDownload;
		private var _fileUpload:SquareProcessFileUpload;
		public function SquareProcessController(gridModel:GridModel)
		{
			_gridModel = gridModel;
			_fileDownload = new SquareProcessFileDownload();
			_fileDownload.addEventListener(Event.COMPLETE, _templateDownloaded);
			_fileUpload = new SquareProcessFileUpload();
			_fileUpload.addEventListener(Event.COMPLETE, _templateLoaded);
		}
		
		public function book():void
		{
			_responder = new Responder(_book, _onFault);
			Gateway.getInstance().call("square.book", _responder, _gridModel.focusY, _gridModel.focusX, _gridModel.issueSlug);
		}
		
		private function _book(result:Object):void
		{
			if(result){
				_fileDownload.setURI(result.template_url);
				dispatchEvent(new SquareProcessEvent(SquareProcessEvent.BOOKED));
			}
		}
		
		public function release():void
		{
			_responder = new Responder(_released, _onFault);
			Gateway.getInstance().call("square.release", _responder, _gridModel.focusY, _gridModel.focusX, _gridModel.issueSlug);
		}
		
		private function _released(result:Object):void
		{
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.CANCELED));
		}
		
		public function loadTemplate():void
		{
			_responder = new Responder(_template, _onFault);
			Gateway.getInstance().call("square.template", _responder, _gridModel.focusY, _gridModel.focusX, _gridModel.issueSlug);
		}
		
		public function template():void
		{
			_fileDownload.downloadTpl();
		}
		
		private function _templateDownloaded(e:Event):void
		{
			trace("template downloaded");
		}
		
		private function _template(result:Object):void
		{
			_fileDownload.setURI(result as String);
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.DOWNLOAD));
		}
		
		public function fill():void
		{
			_fileUpload.browseTpl();
		}
		
		public function _templateLoaded(e:Event):void
		{
			var data:ByteArray = new ByteArray();
			_fileUpload.data.readBytes(data, 0, _fileUpload.data.length);
			_responder = new Responder(_uploaded, _onFault);
			Gateway.getInstance().call("square.fill", _responder, _gridModel.focusY, _gridModel.focusX, _gridModel.issueSlug, data);
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.UPLOADING));
		}
		
		public function _uploaded(result:Object):void
		{
			trace(result);
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.SUCCESS));
		}
		
		public function reload():void
		{
			trace('reload issue');
		}
	}
}