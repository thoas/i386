package cc.milkshape.grid
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.gateway.Gateway;
	import cc.milkshape.grid.layer.LayerLoader;
	import cc.milkshape.grid.layer.events.LayerEvent;
	import cc.milkshape.grid.square.*;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.manager.SoundManager;
	
	import nl.demonsters.debugger.MonsterDebugger;

	public class GridController extends GatewayController
	{
		private var _gridModel:GridModel;
		private var _loader:LayerLoader;
		private var _soundSquareFocus:SoundSquareFocus;
		
		public function GridController(gridModel:GridModel)
		{	
			super();
			SoundManager.getInstance().addLibrarySound(SoundSquareFocus, "SoundSquareFocus");
			//_soundSquareFocus = new SoundSquareFocus();
			
			_gridModel = gridModel;
		}
		
		public function getGridInfo():void
		{
			Gateway.getInstance().call("issue.issue", _responder, _gridModel.issueSlug);
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
			var i:int;
			for(i = 0; i <= scales['maxScale']; i++)
			{
				if(minSquareWidth >=  _gridModel.issue.steps[i] && minSquareWidth < _gridModel.issue.steps[i + 1])// on détermine le pas de zoom minimum
				{
					 scales['minScale'] = i;
					 break;
				}
			}
			
			_gridModel.currentScale = _gridModel.minScale = scales['minScale'];
			
			return scales;
		}
		
		private function _handlerLayerLoaded(e:LayerEvent):void
		{
			dispatchEvent(e.clone());
		}
        
        public function loadImage():void
		{
			var squareFocus:* = _gridModel.focusSquare;
			if(squareFocus is SquareFull){
				var currentLayer:Object = squareFocus.layers[_gridModel.currentStep];
					
				_loader = new LayerLoader();
				_loader.addEventListener(LayerEvent.LAYER_LOADED, _handlerLayerLoaded);
	            _loader.loadLayer(currentLayer, _gridModel.currentScale, _gridModel.currentStep);
			}
		}

		public function onFocusHandler(e:SquareEvent):void
		{
			if(_gridModel.gridLineVisible)
			{
				SoundManager.getInstance().playSound("SoundSquareFocus");
				trace("layer " + e.square.X + " " + e.square.Y);
				_gridModel.setFocus(e.square.X, e.square.Y);
				_gridModel.moveTo();
			}
		}
		
		public function onFocusOutHandler(e:SquareEvent):void
		{
			_gridModel.lastFocusX = e.square.X;
			_gridModel.lastFocusY = e.square.Y;
		}
		
		public function getFocusSquare():Square {
			return _gridModel.focusSquare;
		}
	}
}