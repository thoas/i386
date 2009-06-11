package cc.milkshape.grid
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.grid.events.GridZoomEvent;
	import cc.milkshape.grid.layer.Layer;
	import cc.milkshape.grid.layer.LayerLoader;
	import cc.milkshape.grid.layer.LayerLoaderManager;
	import cc.milkshape.grid.layer.events.LayerEvent;
	import cc.milkshape.grid.square.*;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.manager.SoundManager;
	import nl.demonsters.debugger.MonsterDebugger;

	public class GridController extends GatewayController
	{
		private var _gridModel:GridModel;
		private var _loader:LayerLoader;
		private var _listLayers:Array;
		private var _soundSquareFocus:SoundSquareFocus;
		
		public function GridController(gridModel:GridModel)
		{	
			super();
			SoundManager.getInstance().addLibrarySound(SoundSquareFocus, "SoundSquareFocus");
			//_soundSquareFocus = new SoundSquareFocus();
			
			_connect("issue/gateway/");

			_gridModel = gridModel;
		}
		
		public function getGridInfo():void
		{
			_gateway.call("issue.issue", _responder, _gridModel.issueSlug);
		}
		
		override protected function _onResult(result:Object):void {
			var issue:Object = result.issue;
			_gridModel.issue = issue;
			_gridModel.initSquares(result.squares, result.squares_open)
		}

		public function defineScale(stageHeight:int, stageWidth:int, stagePadding:int):Array
		{
			var scales:Array = new Array();
			scales['maxScale'] = _gridModel.issue.steps.indexOf(_gridModel.squareSize)
			_gridModel.maxScale = scales['maxScale'];
			var minSquareWidth:Number = stageWidth > stageHeight ? (stageHeight - stagePadding) / _gridModel.nbVSquare : (stageWidth - stagePadding) / _gridModel.nbHSquare;
			
			var index:int;
			for(var i:int = 0; i <= scales['maxScale']; i++)
			{
				if(minSquareWidth >=  _gridModel.issue.steps[i] && minSquareWidth < _gridModel.issue.steps[i + 1])// on détermine le pas de zoom minimum
				{
					 scales['minScale'] = i;
					 break;
				}
			}
			
			_gridModel.currentScale = _gridModel.minScale = scales['minScale'];
			_gridModel.dispatchEvent(new GridZoomEvent(GridZoomEvent.ZOOM, scales['minScale']));
			
			_listLayers = new Array();
			for(i = scales['minScale']; i <= scales['maxScale']; i++)
			{
				_listLayers[i] = new Layer(i);
			}
			
			return scales;
		}
		
		public function getLayer(i:int):Layer
		{
			return _listLayers[i];
		}
		
		private function _handlerLayerLoaded(e:LayerEvent):void
		{
			_listLayers[e.currentScale].addThumb(e.thumb, e.posX, e.posY, _gridModel.squareSize, e.currentStep);
		}
        
        public function loadImage():void
		{
			var squareFocus:* = _gridModel.focusSquare;
			if(squareFocus is SquareFull){
				//MonsterDebugger.trace(this, _gridModel.issue);
				
				var currentLayer:Object = squareFocus.layers[_gridModel.currentStep];
					
				_loader = new LayerLoader();
				_loader.addEventListener(LayerEvent.LAYER_LOADED, _handlerLayerLoaded);
	            _loader.loadLayer(currentLayer, _gridModel.currentScale, _gridModel.currentStep);
	            
				trace('=> ' + currentLayer.url);
			}
		}

		public function onFocusHandler(e:SquareEvent):void
		{
			if(_gridModel.gridLineVisible)
			{
				SoundManager.getInstance().playSound("SoundSquareFocus");
				_gridModel.setFocus(e.square.X, e.square.Y);
				_gridModel.moveTo();
			}
		}
		
		public function getFocusSquare():Square {
			return _gridModel.focusSquare;
		}
	}
}