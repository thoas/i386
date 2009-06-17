package cc.milkshape.grid.process
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.grid.process.events.SquareProcessEvent;

	public class SquareProcessController extends GatewayController
	{
		public function SquareProcessController()
		{
		}
		
		public function book():void
		{
			dispatchEvent(new SquareProcessEvent(SquareProcessEvent.BOOKED));
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