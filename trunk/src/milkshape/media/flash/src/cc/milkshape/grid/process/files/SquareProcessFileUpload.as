package cc.milkshape.grid.process.files
{
	import flash.events.Event;
	import flash.net.FileReference;

	public class SquareProcessFileUpload extends SquareProcessFile
	{
		public function SquareProcessFileUpload(URI:String = null)
		{
			super(URI);
		}
		
		public function browseTpl(typeFilter:Array = null) : Boolean
		{
			return browse(_getTypes());
		}
		
		override protected function _configureListeners():void
		{
			//_configureListeners();
			addEventListener(Event.SELECT, _selectHandler);
		}

        private function _selectHandler(event:Event):void {
            var file:FileReference = FileReference(event.target);
            file.load();
            //file.upload(_request);
        }
	}
}