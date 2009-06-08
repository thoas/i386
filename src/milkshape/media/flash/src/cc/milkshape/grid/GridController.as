package cc.milkshape.grid
{
	import cc.milkshape.gateway.GatewayController;
	import cc.milkshape.grid.events.GridZoomEvent;
	import cc.milkshape.grid.square.*;
	import cc.milkshape.grid.square.events.SquareEvent;
	import cc.milkshape.manager.SoundManager;
	import cc.milkshape.utils.Constance;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	public class GridController extends GatewayController
	{
		private var _gridModel:GridModel;
		private var _loader:Loader;
		private var _listLayers:Array;
		private var _issue:Object;
		private var _squaresOpen:Object;
		private var _squares:Object;
		private var _soundSquareFocus:SoundSquareFocus;
		
		public function GridController(gridModel:GridModel)
		{	
			super();
			SoundManager.getInstance().addLibrarySound(SoundSquareFocus, "SoundSquareFocus");
			//_soundSquareFocus = new SoundSquareFocus();
			
			_connect("issue/gateway");
			
			_gridModel = gridModel;
			
			_loader = new Loader();// Un seul loader... donc un seul téléchargement possible à la fois
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
		}
		
		public function getGridInfo():void
		{
			_gateway.call("issue.issue", _responder, '5x5');
		}
		
		override protected function _onResult(result:Object):void {
			MonsterDebugger.trace(this, result);
			_issue = result.issue;
			_squaresOpen = result.t_squares_open;
			_squares = result.t_squares;
			MonsterDebugger.trace(this, _issue);
			_gridModel.init(_issue.min_x, _issue.min_y, _issue.max_x, _issue.max_y, _issue.nb_case_x, _issue.nb_case_y, _issue.show_disable_square, _issue.size);
		}
		
		public function getGridSquares():void
		{
			var squares:Array = new Array();
			for(var squareCoord:Object in _squares){
				squares.push(_squares[squareCoord]);
			}
			MonsterDebugger.trace(this, squares);
			
			var squaresOpen:Array = new Array();
			for(var squareOpenCoord:Object in _squaresOpen){
				squaresOpen.push(_squaresOpen[squareOpenCoord]);
			}
			MonsterDebugger.trace(this, squaresOpen);
			
			_gridModel.initSquares(squares, squaresOpen);
		}
		
		public function defineScale(stageHeight:int, stageWidth:int, stagePadding:int):Array
		{
			var scales:Array = new Array();
			scales['maxScale'] = Constance.SCALE_THUMB.indexOf(_gridModel.squareSize)
			_gridModel.maxScale = scales['maxScale'];
			
			var minSquareWidth:Number = stageWidth > stageHeight ? (stageHeight - stagePadding) / _gridModel.nbVSquare : (stageWidth - stagePadding) / _gridModel.nbHSquare;
			
			var index:int;
			for(var i:int = 0; i <= scales['maxScale']; i++)
			{
				if(minSquareWidth >=  Constance.SCALE_THUMB[i] && minSquareWidth < Constance.SCALE_THUMB[i + 1])// on détermine le pas de zoom minimum
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
		
		private function _completeHandler(e:Event):void
		{
			var o:LoaderInfo = LoaderInfo(e.target);
			_listLayers[_gridModel.currentScale].addThumb(Bitmap(o.content), 2, 2);
        }

		private function _ioErrorHandler(event:IOErrorEvent):void
		{
            trace('Unable to load image');
        }
        
        public function loadImage(scale:int):void
		{
			_loader.load(new URLRequest('../img/' + '1_1' + '_' + Constance.SCALE_THUMB[scale] + '.jpg'));
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
			return SquareManager.get(_gridModel.focusSquare);
		}
	}
}