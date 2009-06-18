package cc.milkshape.grid.process
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.grid.GridModel;
	import cc.milkshape.grid.process.events.SquareProcessEvent;
	import cc.milkshape.grid.process.files.SquareProcessFile;
	
	import flash.net.Responder;

	public class SquareProcessController extends GatewayController
	{
		private var _gridModel:GridModel;
		private var _file:SquareProcessFile;
		public function SquareProcessController(gridModel:GridModel)
		{
			_gridModel = gridModel;
			_file = new SquareProcessFile();
			_connect("square/gateway/");
		}
		
		public function book():void
		{
			_responder = new Responder(_book, _onFault);
			_gateway.call("square.book", _responder, _gridModel.focusX, _gridModel.focusY, _gridModel.issueSlug);
		}
		
		private function _book(result:Object):void
		{
			if(result){
				_file.setURI(result.template_url);
				dispatchEvent(new SquareProcessEvent(SquareProcessEvent.BOOKED));
			}
		}
		
		public function release():void
		{
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.CANCELED));
		}
		
		public function template():void
		{
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.DOWNLOAD));
		}
		
		public function fill():void
		{
			//dispatchEvent(new SquareProcessEvent(SquareProcessEvent.UPLOADING));
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.SUCCESS));
		}
		
		public function reload():void
		{
			trace('reload issue');
		}
	}
}