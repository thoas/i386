package cc.milkshape.grid
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.grid.events.GridZoomEvent;
	import cc.milkshape.grid.square.*;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.manager.SoundManager;
	import cc.milkshape.utils.Constance;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.display.Loader;
	import flash.net.Responder;
	import flash.display.LoaderInfo;
	import flash.net.URLRequest;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class GridController extends GatewayController
	{
		private var _gridModel:GridModel;
		private var _loader:Loader;
		private var _listLayers:Array;
		private var _soundSquareFocus:SoundSquareFocus;
		
		public function GridController(gridModel:GridModel)
		{	
			super();
			SoundManager.getInstance().addLibrarySound(SoundSquareFocus, "SoundSquareFocus");
			//_soundSquareFocus = new SoundSquareFocus();
			
			_connect("issue/gateway/");

			_gridModel = gridModel;
			
			_loader = new Loader();// Un seul loader... donc un seul téléchargement possible à la fois
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
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
			trace(_gridModel.nbVSquare);
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
			
			trace(scales['minScale']);
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
		
		private function _completeHandler(e:Event):void
		{
			var o:LoaderInfo = LoaderInfo(e.target);
			_listLayers[_gridModel.currentScale].addThumb(Bitmap(o.content), 0, 0, _gridModel.issue.size, _gridModel.currentStep);
        }

		private function _ioErrorHandler(event:IOErrorEvent):void
		{
            trace('Unable to load image');
        }
        
        public function loadImage():void
		{
			var squareFocus:* = _gridModel.focusSquare;
			if(squareFocus is SquareFull){
				MonsterDebugger.trace(this, _gridModel.issue);
				
				trace(squareFocus.layers[_gridModel.currentStep].url);
			}
			//_loader.load(new URLRequest(Constance.url('media/layer/0_0__'+ _gridModel.issue.steps[_gridModel.currentScale]+'__5x5.png')));
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