package grid
{
	import caurina.transitions.Tweener;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import grid.square.*;
	
	import utils.Constance;
	
	public class GridView extends Sprite
	{
		private var _controller:GridController;
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
		
		public function GridView(model:GridModel, controller:GridController)
		{
			_lineColor = 0x1E1E1E;
			_stagePadding = 50;
			_speed = 800;
			_controller = controller;
			_model = model;
			
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{			
			_model.addEventListener(GridEvent.INFO_READY, _handlerGridInfoReady);
			_controller.getGridInfo();
		}
		
		private function _handlerGridInfoReady(e:GridEvent):void
		{
			var scales:Array = _controller.defineScale(stage.stageHeight, stage.stageWidth, _stagePadding);
			_minScale = scales['minScale'];
			_maxScale = scales['maxScale'];
			
			for(var i:int = _minScale; i <= _maxScale; i++)
			{
				addChild(_controller.getLayer(i));
			}
			
			_layerSquare = new Sprite();
			addChild(_layerSquare);
			
			_nbHSquare = e.nbHSquare;
			_nbVSquare = e.nbVSquare;	
			_squareSize = e.squareSize;
			_model.addEventListener(SquareEvent.CREATION, _addSquare);
			_model.addEventListener(GridEvent.READY, _handlerGridReady);
			_controller.getGridSquares();
		}
		
		private function _handlerGridReady(e:GridEvent):void
		{            
			_layerSquare.addChild(new GridLine(_nbHSquare, _nbVSquare, _squareSize, _lineColor));
			
			width = Constance.SCALE_THUMB[_minScale] * _nbHSquare;
			scaleY = scaleX;
			
			_model.addEventListener(GridFocusEvent.FOCUS, _squarePutFocus);
			_model.addEventListener(GridMoveEvent.MOVE, _moveTo);
			_model.addEventListener(GridZoomEvent.ZOOM, _zoomTo);
			
			addEventListener(MouseEvent.CLICK, _controller.clickHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK, _controller.doubleClickHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _controller.keyDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, _controller.mouseWheelHandler);
			stage.addEventListener(Event.RESIZE, _resize);
			
			_resize();
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
			square.addEventListener(SquareEvent.OVER, _controller.rollOverHandler);
			square.addEventListener(SquareEvent.FOCUS, _controller.onFocusHandler);// Focus : tabulation, clic, double clic, clavier...
			_layerSquare.addChild(square);
		}
		
		private function _zoomTo(e:GridZoomEvent):void
		{			
			Tweener.addTween(
				this,
				{
					width: Constance.SCALE_THUMB[e.currentScale] * _nbHSquare,
					height: Constance.SCALE_THUMB[e.currentScale] * _nbVSquare,
					time: _speed/1000,
					transition: 'easeOutSine'
				}
			);
		}
		
		private function _moveTo(e:GridMoveEvent):void
		{			
			Tweener.addTween(
				this,
				{
					x: Math.round(stage.stageWidth / 2 - e.decalX),
					y: Math.round(stage.stageHeight / 2 - e.decalY),
					time: _speed/1000,
					transition: 'easeOutSine'
				}
			);
		}
		
		private function _squarePutFocus(e:GridFocusEvent):void
		{
			stage.focus = _controller.getFocusSquare();// On mets le focus sur la Square correspondante
		}
		
	}
}