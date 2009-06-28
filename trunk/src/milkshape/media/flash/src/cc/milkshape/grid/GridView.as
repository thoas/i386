package cc.milkshape.grid
{
	import cc.milkshape.framework.mvc.View;
	import cc.milkshape.grid.events.GridEvent;
	import cc.milkshape.grid.events.GridFocusEvent;
	import cc.milkshape.grid.events.GridLineEvent;
	import cc.milkshape.grid.events.GridMoveEvent;
	import cc.milkshape.grid.events.GridZoomEvent;
	import cc.milkshape.grid.layer.Layer;
	import cc.milkshape.grid.layer.events.LayerEvent;
	import cc.milkshape.grid.square.*;
	import cc.milkshape.grid.square.events.SquareEvent;
	
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Sine;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;

	public class GridView extends View
	{
		private var _controller:GridController;
		private var _keyboardController:GridKeyboardController;
		private var _mouseController:GridMouseController;
		private var _steps:Array;
		private var _model:GridModel;
		private var _squareSize:int;// Taille des carrés
		private var _maxScale:int;// Echelle maximum
		private var _minScale:int;// Echelle minium
		private var _stagePadding:int;// Espace minimum entre la grille et la scène
		private var _lineColor:int;// Couleur des lignes de la grille
		private var _speed:int;// Vitesse en millisecondes
		private var _nbHSquare:int;// Nombre de carrés à l'horizontal
		private var _nbVSquare:int;// Nombre de carrés à la vertical
		private var _layerSquare:Sprite;// Le calque qui contient les squares
		private var _gridLine:GridLine;
		private var _listLayers:Array;
		
		public function GridView(model:GridModel, controller:GridController, keyboardController:GridKeyboardController, mouseController:GridMouseController)
		{
			_lineColor = 0x343434;
			_stagePadding = 50;
			_speed = 800;
			_controller = controller;
			_keyboardController = keyboardController;
			_mouseController = mouseController;
			_model = model;
			
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _handlerRemovedFromStage);
		}
		
		public function get keyboardController():GridKeyboardController
		{
			return _keyboardController;
		}

		public function set keyboardController(v:GridKeyboardController):void
		{
			_keyboardController = v;
		}

		public function get mouseController():GridMouseController
		{
			return _mouseController;
		}

		public function set mouseController(v:GridMouseController):void
		{
			_mouseController = v;
		}

		private function _handlerAddedToStage(e:Event):void
		{		
			removeEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);	
			_model.addEventListener(GridEvent.INFO_READY, _handlerGridInfoReady);
			_controller.getGridInfo();
		}
		
		private function _handlerRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, _handlerRemovedFromStage);
			stage.removeEventListener(Event.RESIZE, _resize);
			
			removeEventListener(MouseEvent.CLICK, _mouseController.clickHandler);
			removeEventListener(MouseEvent.DOUBLE_CLICK, _mouseController.doubleClickHandler);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, _mouseController.mouseWheelHandler);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, _keyboardController.keyDownHandler);

			_model.removeEventListener(SquareEvent.CREATION, _addSquare);
			
			_model.removeEventListener(GridEvent.INFO_READY, _handlerGridInfoReady);
			_model.removeEventListener(GridEvent.READY, _handlerGridReady);
			_model.removeEventListener(GridFocusEvent.FOCUS, _squarePutFocus);
			_model.removeEventListener(GridMoveEvent.MOVE, _moveTo);
			_model.removeEventListener(GridZoomEvent.ZOOM, _zoomTo);
			_model.removeEventListener(GridLineEvent.SHOW, _showGridLine);
			_model.removeEventListener(GridLineEvent.HIDE, _hideGridLine);
		}
		
		private function _handlerGridInfoReady(e:GridEvent):void
		{
			var scales:Array = _controller.defineScale(stage.stageHeight, stage.stageWidth, _stagePadding);
			_minScale = scales['minScale'];
			_maxScale = scales['maxScale'];
			
			_listLayers = new Array();
			for(var i:int = scales['minScale']; i <= scales['maxScale']; i++)
			{
				_listLayers[i] = new Layer(i);
				addChild(_listLayers[i]);
			}
			
			_layerSquare = new Sprite();
			addChild(_layerSquare);
			
			_steps = e.steps;
			_nbHSquare = e.nbHSquare;
			_nbVSquare = e.nbVSquare;	
			_squareSize = e.squareSize;
			_model.addEventListener(SquareEvent.CREATION, _addSquare);
			_model.addEventListener(GridEvent.READY, _handlerGridReady);
		}
		
		private function _handlerGridReady(e:GridEvent):void
		{
			_gridLine = new GridLine(_nbHSquare, _nbVSquare, _squareSize, _lineColor);
			_layerSquare.addChild(_gridLine);
			_model.addEventListener(GridLineEvent.SHOW, _showGridLine);
			_model.addEventListener(GridLineEvent.HIDE, _hideGridLine);
			
			width = _steps[_minScale] * _nbHSquare;
			scaleY = scaleX;
			
			_model.addEventListener(GridFocusEvent.FOCUS, _squarePutFocus);
			_model.addEventListener(GridMoveEvent.MOVE, _moveTo);
			_model.addEventListener(GridZoomEvent.ZOOM, _zoomTo);
			
			_controller.addEventListener(LayerEvent.LAYER_LOADED, _handlerLayerThumb);
			
			
			addEventListener(MouseEvent.CLICK, _mouseController.clickHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK, _mouseController.doubleClickHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyboardController.keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, _keyboardController.keyUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mouseController.mouseWheelHandler);
			stage.addEventListener(Event.RESIZE, _resize);

			_resize();
			dispatchEvent(new GridEvent(GridEvent.VIEW_READY));
		}
		
		private function _handlerLayerThumb(e:LayerEvent):void
		{
			_listLayers[e.currentScale].addThumb(e.thumb, e.posX, e.posY, _squareSize, e.currentStep);
		}
		
		private function _resize(e:Event = null):void
		{
			x = Math.round(stage.stageWidth / 2 - width / 2);
			y = Math.round(stage.stageHeight / 2 - height / 2);
		}
		
		private function _addSquare(e:SquareEvent):void
		{
			var square:Square = e.square;
			square.x = square.X * _squareSize;
			square.y = square.Y * _squareSize;
			square.tabIndex = _nbHSquare * square.Y + square.X;// Numéro tabulation = nombre de colonne * y + x
			square.addEventListener(SquareEvent.OVER, _mouseController.rollOverHandler);
			square.addEventListener(SquareEvent.FOCUS, _controller.onFocusHandler);// Focus : tabulation, clic, double clic, clavier...
			square.addEventListener(SquareEvent.FOCUS_OUT, _controller.onFocusOutHandler);
			_layerSquare.addChild(square);
		}
		
		private function _removeControllerEventListener():void
		{
			removeEventListener(MouseEvent.CLICK, _mouseController.clickHandler);
			removeEventListener(MouseEvent.DOUBLE_CLICK, _mouseController.doubleClickHandler);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, _mouseController.mouseWheelHandler);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, _keyboardController.keyDownHandler);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, _mouseController.mouseDownMagnet);
			stage.addEventListener(MouseEvent.MOUSE_UP, _mouseController.mouseUpMagnet);
			addEventListener(MouseEvent.MOUSE_DOWN, _mouseController.mouseDownMagnet);
			addEventListener(MouseEvent.MOUSE_UP, _mouseController.mouseUpMagnet);
		}
		
		private function _addControllerEventListener():void
		{
			addEventListener(MouseEvent.CLICK, _mouseController.clickHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK, _mouseController.doubleClickHandler);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mouseController.mouseWheelHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _keyboardController.keyDownHandler);
			
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, _mouseController.mouseDownMagnet);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _mouseController.mouseUpMagnet);
			removeEventListener(MouseEvent.MOUSE_DOWN, _mouseController.mouseDownMagnet);
			removeEventListener(MouseEvent.MOUSE_UP, _mouseController.mouseUpMagnet);
		}
		
		private function _hideGridLine(e:GridLineEvent):void
		{
			Mouse.hide();
			_removeControllerEventListener();
			new GTween(
				_gridLine, 
				_speed * 0.0005, {
				alpha: 0 }, {
				ease:Sine.easeOut}
			);
		}
		
		private function _showGridLine(e:GridLineEvent):void
		{
			Mouse.show();
			_addControllerEventListener();
			new GTween(
				_gridLine, 
				_speed * 0.0005, {
				alpha: 1 }, {
				ease:Sine.easeOut}
			);
		}
		
		private function _zoomTo(e:GridZoomEvent):void
		{
			new GTween(
				this, 
				_speed * 0.001, {
				width: _steps[e.currentScale] * _nbHSquare,
				height: _steps[e.currentScale] * _nbVSquare }, {
				ease:Sine.easeOut}
			);
		}
		
		private function _moveTo(e:GridMoveEvent):void
		{
			new GTween(
				this, 
				_speed * 0.001, {
				x: Math.round(stage.stageWidth / 2 - e.decalX),
				y: Math.round(stage.stageHeight / 2 - e.decalY) }, {
				ease:Sine.easeOut}
			);
			_controller.loadImage();
		}
		
		private function _squarePutFocus(e:GridFocusEvent):void
		{
			stage.focus = _controller.getFocusSquare();// On mets le focus sur la Square correspondante
		}
		
	}
}