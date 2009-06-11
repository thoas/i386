package cc.milkshape.grid.layer
{
	import cc.milkshape.grid.layer.events.LayerEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.LoaderContext;

	public class LayerLoader extends Loader
	{
		public function LayerLoader()
		{
			contentLoaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
            contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);	
		}
		
		public function loadLayer(currentLayer:Object, currentScale:int, currentStep:int):void 
		{
			if(!LayerLoaderManager.contains(currentLayer.url)){
				var urlRequest:URLRequest =  new URLRequest(currentLayer.url);
				var variables:URLVariables = new URLVariables();
				variables.posX = currentLayer.pos_x;
				variables.posY = currentLayer.pos_y;
				variables.currentScale = currentScale;
				variables.currentStep = currentStep;
				variables.url = currentLayer.url;
				urlRequest.data = variables;
				load(urlRequest);
				trace('=> ' + currentLayer.url);
			}
		}
		
		override public function load(request:URLRequest, context:LoaderContext = null):void
		{
			super.load(request, context);
		}

		private function _completeHandler(e:Event):void
		{
			var o:LoaderInfo = LoaderInfo(e.target);
			var posX:int = o.parameters.posX;
			var posY:int = o.parameters.posY;
			var currentScale:int = o.parameters.currentScale;
			var currentStep:int = o.parameters.currentStep;
			
			trace('<= ' + o.parameters.url);
			var thumb:Bitmap = Bitmap(o.content);
			LayerLoaderManager.add(o.parameters.url, thumb);
			dispatchEvent(new LayerEvent(LayerEvent.LAYER_LOADED, thumb, posX, posY, currentScale, currentStep));
        }

		private function _ioErrorHandler(event:IOErrorEvent):void
		{
            trace('Unable to load image');
        }
	}
}