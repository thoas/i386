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
		private var _fileDownload:SquareProcessFileDownload;
		private var _fileUpload:SquareProcessFileUpload;
		public function SquareProcessController()
		{
			_fileDownload = new SquareProcessFileDownload();
			_fileDownload.addEventListener(Event.COMPLETE, _templateDownloaded);
			_fileUpload = new SquareProcessFileUpload();
		}
		
		public function book(posX:int, posY:int, issueSlug:String):void
		{
			_responder = new Responder(
				function _book(result:Object):void
				{
					if(result){
						_fileDownload.setURI(result.template_url);
						dispatchEvent(new SquareProcessEvent(SquareProcessEvent.BOOKED));
					}
				}
			, _onFault);
			Gateway.getInstance().call("square.book", _responder, posX, posY, issueSlug);
		}
		
		public function release(posX:int, posY:int, issueSlug:String):void
		{
			_responder = new Responder(
				function _released(result:Object):void
				{
					dispatchEvent(new SquareProcessEvent(SquareProcessEvent.CANCELED));
				}
			, _onFault);
			Gateway.getInstance().call("square.release", _responder, posX, posY, issueSlug);
		}
		
		public function loadTemplate(posX:int, posY:int, issueSlug:String):void
		{
			_responder = new Responder(
				function _template(result:Object):void
				{
					_fileDownload.setURI(result as String);
					dispatchEvent(new SquareProcessEvent(SquareProcessEvent.DOWNLOAD));
				}
			, _onFault);
			Gateway.getInstance().call("square.template", _responder, posX, posY, issueSlug);
		}
		
		public function template():void
		{
			_fileDownload.downloadTpl();
		}
		
		public function reload():void
		{
			trace('reload issue');
		}
		
		public function show():void
		{
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.SHOW));
		}
		
		public function hide():void
		{
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.HIDE));
		}
		
		public function fill(posX:int, posY:int, issueSlug:String):void
		{
			_fileUpload.addEventListener(Event.COMPLETE, 
				function(e:Event):void
				{
					dispatchEvent(new SquareProcessEvent(SquareProcessEvent.UPLOADING));
					var data:ByteArray = new ByteArray();
					_fileUpload.data.readBytes(data, 0, _fileUpload.data.length);
					_responder = new Responder(_uploaded, _onFault);
					Gateway.getInstance().call("square.fill", _responder, posX, posY, issueSlug, data);
					dispatchEvent(new SquareProcessEvent(SquareProcessEvent.UPLOADING2));
				}
			);
			_fileUpload.browseTpl();
		}
		
		private function _uploaded(result:Object):void
		{
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.SUCCESS));
		}
		
		private function _templateDownloaded(e:Event):void
		{
			trace("template downloaded");
		}
	}
}