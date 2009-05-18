package grid
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	import grid.square.*;
	
	import utils.Constance;
	
	public class GridController
	{
		private var _gridModel:GridModel;
		private var _overX:int;
		private var _overY:int;
		private var _isShowForm:Boolean;
		private var _loader:Loader;
		private var _listLayers:Array;
		
		public function GridController(gridModel:GridModel)
		{
			_gridModel = gridModel;
			_isShowForm = false;
			
			_loader = new Loader();// Un seul loader... donc un seul téléchargement possible à la fois
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, _completeHandler);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _ioErrorHandler);
		}
		
		public function getGridInfo():void
		{
			// On envoit une requête en POST avec issue_id
			// On reçoit les infos de l'issue
			var issue:Object = new Object();
			issue.title = 'Bac à sable';
			issue.text_presentation = 'Bac à sable desc';
			issue.nb_square_x = 0;
			issue.nb_square_y = 0;
			issue.show_disable_square = 1;
			issue.max_participation = 1;
			issue.min_x = 0;
			issue.max_x = 4;
			issue.min_y = 0;
			issue.max_y = 4;
			issue.square_size = 800;
			
			_gridModel.init(issue.min_x, issue.min_y, issue.max_x, issue.max_y, issue.nb_square_x, issue.nb_square_y, issue.show_disable_square, issue.square_size);
		}
		
		public function getGridSquares():void
		{
			// On envoit une requête en POST avec issue_id
			// On reçoit des les squares correspondants
			var sq1:Object = new Object();
			sq1.pos_x = 1;
			sq1.pos_y = 1;
			sq1.background_image_path = '1_1';
			sq1.status = 1;
			
			var sq2:Object = new Object();
			sq2.pos_x = 2;
			sq2.pos_y = 1;
			sq2.background_image_path = '1_2';
			sq2.status = 1;
			
			var sq3:Object = new Object();
			sq3.pos_x = 3;
			sq3.pos_y = 1;
			sq3.background_image_path = '1_3';
			sq3.status = 1;
			
			var sq4:Object = new Object();
			sq4.pos_x = 1;
			sq4.pos_y = 2;
			sq4.background_image_path = '2_1';
			sq4.status = 1;
			
			var sq5:Object = new Object();
			sq5.pos_x = 2;
			sq5.pos_y = 2;
			sq5.background_image_path = '2_2';
			sq5.status = 1;
			
			var sq6:Object = new Object();
			sq6.pos_x = 3;
			sq6.pos_y = 2;
			sq6.background_image_path = '2_3';
			sq6.status = 1;
			
			var sq7:Object = new Object();
			sq7.pos_x = 1;
			sq7.pos_y = 3;
			sq7.background_image_path = '3_1';
			sq7.status = 1;
			
			var sq8:Object = new Object();
			sq8.pos_x = 2;
			sq8.pos_y = 3;
			sq8.background_image_path = '3_2';
			sq8.status = 1;
			
			var sq9:Object = new Object();
			sq9.pos_x = 3;
			sq9.pos_y = 3;
			sq9.background_image_path = '3_3';
			sq9.status = 1;
			
			var sq10:Object = new Object();
			sq10.pos_x = 2;
			sq10.pos_y = 0;
			sq10.background_image_path = null;
			sq10.status = 0;
			
			var sq11:Object = new Object();
			sq11.pos_x = 1;
			sq11.pos_y = 4;
			sq11.background_image_path = null;
			sq11.status = 0;
			
			var sqo1:Object = new Object();
			sqo1.pos_x = 0;
			sqo1.pos_y = 0;
			
			var sqo2:Object = new Object();
			sqo2.pos_x = 4;
			sqo2.pos_y = 4;
			
			var sqo3:Object = new Object();
			sqo3.pos_x = 0;
			sqo3.pos_y = 1;
			
			var sqo4:Object = new Object();
			sqo4.pos_x = 0;
			sqo4.pos_y = 2;
			
			var sqo5:Object = new Object();
			sqo5.pos_x = 3;
			sqo5.pos_y = 4;
			
			var sqo6:Object = new Object();
			sqo6.pos_x = 4;
			sqo6.pos_y = 0;
			
			var sqo7:Object = new Object();
			sqo7.pos_x = 4;
			sqo7.pos_y = 1;
			
			var sqo8:Object = new Object();
			sqo8.pos_x = 4;
			sqo8.pos_y = 2;
			
			var sqo9:Object = new Object();
			sqo9.pos_x = 4;
			sqo9.pos_y = 3;
			
			
			_gridModel.initSquares(new Array(sq1, sq2, sq3, sq4, sq5, sq6, sq7, sq8, sq9, sq10, sq11), new Array(sqo1, sqo2, sqo3, sqo4, sqo5, sqo6, sqo7, sqo8, sqo9));
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
		
		public function zoomTo(op:int):void
		{			
			var futurScale:int = _gridModel.currentScale + op < _gridModel.minScale ? _gridModel.minScale : _gridModel.currentScale + op > _gridModel.maxScale ? _gridModel.maxScale : _gridModel.currentScale + op;
			
			if(_gridModel.currentScale != futurScale)// Si le zoom change
			{
				if(_isShowForm)
				{
					_isShowForm = false;
					_gridModel.dispatchEvent(new SquareFormEvent(SquareFormEvent.CLOSE));
				}
				_gridModel.currentScale = futurScale;
				_loadImage(futurScale);
				_gridModel.dispatchEvent(new GridZoomEvent(GridZoomEvent.ZOOM, futurScale));
				_moveTo();
			}
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
        
        private function _loadImage(scale:int):void
		{
			_loader.load(new URLRequest('img/' + '1_1' + '_' + Constance.SCALE_THUMB[scale] + '.jpg'));
		}
		
		private function _moveTo():void
		{
			if(_gridModel.currentScale == _gridModel.maxScale)// Si on est au zoom maximal
			{
				var square:Square = getFocusSquare();
				if(square is SquareOpen)
				{
					_isShowForm = true;
					_gridModel.dispatchEvent(new SquareFormEvent(SquareFormEvent.SHOW_OPEN));
				}
				else if(square is SquareBooked)
				{
					_isShowForm = true;
					_gridModel.dispatchEvent(new SquareFormEvent(SquareFormEvent.SHOW_BOOKED));
				}
				else if(_isShowForm)
				{
					_isShowForm = false;
					_gridModel.dispatchEvent(new SquareFormEvent(SquareFormEvent.CLOSE));
				}
			}
				
			if(_gridModel.currentScale != _gridModel.minScale)// Si on n'est pas au zoom minimal
			{
				_gridModel.dispatchEvent(new GridMoveEvent(
						GridMoveEvent.MOVE, 
						_gridModel.focusX * Constance.SCALE_THUMB[_gridModel.currentScale] + Constance.SCALE_THUMB[_gridModel.currentScale] / 2, 
						_gridModel.focusY * Constance.SCALE_THUMB[_gridModel.currentScale] + Constance.SCALE_THUMB[_gridModel.currentScale] / 2
					)
				);
			}
			else
			{
				_gridModel.dispatchEvent(new GridMoveEvent(
						GridMoveEvent.MOVE, 
						_gridModel.nbVSquare * Constance.SCALE_THUMB[_gridModel.currentScale] / 2, 
						_gridModel.nbHSquare * Constance.SCALE_THUMB[_gridModel.currentScale] / 2
					)
				);
			}
		}
		
		public function getFocusSquare():Square// Renvoit le carré ayant le focus
		{
			return SquareManager.get(_gridModel.focusSquare);
		}
		
		private function _setFocusSquare(X:int, Y:int):void
		{
			_gridModel.focusX = X;
			_gridModel.focusY = Y;
		}
		
		public function rollOverHandler(e:SquareEvent):void
		{
			_overX = e.square.X;
			_overY = e.square.Y;
		}
		
		public function onFocusHandler(e:SquareEvent):void
		{
			_setFocusSquare(e.square.X, e.square.Y);
			_moveTo();
		}
		
		public function mouseWheelHandler(mouseEvent:MouseEvent):void
		{
			_setFocusSquare(_overX, _overY);
			_gridModel.dispatchEvent(new GridFocusEvent(GridFocusEvent.FOCUS));;
			zoomTo(Math.round(mouseEvent.delta/4));
		}
		
		public function clickHandler(mouseEvent:MouseEvent):void
		{
			_setFocusSquare(_overX, _overY);
			zoomTo(mouseEvent.shiftKey ? -1 : 1);	
		}
		
		public function doubleClickHandler(mouseEvent:MouseEvent):void
		{
			zoomTo(mouseEvent.shiftKey ? -_gridModel.maxScale : _gridModel.maxScale);
		}
		
		public function keyDownHandler(e:KeyboardEvent):void
		{
			var x:int = 0;
			var y:int = 0;
				
			switch(e.keyCode)
			{
				case Keyboard.UP:
				case 87: // W
					y = -1 * (e.shiftKey ? _gridModel.nbVSquare : 1);
					break;

				case Keyboard.DOWN:
				case 83: // S
					y = 1 * (e.shiftKey ? _gridModel.nbVSquare : 1);
					break;

				case Keyboard.LEFT:
				case 65: // A
					x = -1 * (e.shiftKey ? _gridModel.nbHSquare : 1);
					break;

				case Keyboard.RIGHT:
				case 68: // D
					x = 1 * (e.shiftKey ? _gridModel.nbHSquare : 1);
					break;

				case Keyboard.PAGE_UP:
					//_pageUpActivated = value;
					break;
					 
				case Keyboard.PAGE_DOWN:
					//_pageDownActivated = value;
					break;

				case Keyboard.HOME:
					//_homeActivated = value;
					break;

				case Keyboard.END:
					//_endActivated = value;
					break;

				case Keyboard.NUMPAD_ADD:
				case 73: // I
					zoomTo(e.shiftKey ? _gridModel.maxScale : 1);
					break;

				case Keyboard.NUMPAD_SUBTRACT:
				case 79: // O
					zoomTo(e.shiftKey ? -_gridModel.maxScale : -1);
					break;
			}
			
			_setFocusSquare(
			  	_gridModel.focusX + x < 0 ? 0 : _gridModel.focusX + x >= _gridModel.nbHSquare ? _gridModel.nbHSquare - 1 : _gridModel.focusX + x,
			  	_gridModel.focusY = _gridModel.focusY + y < 0 ? 0 : _gridModel.focusY + y >= _gridModel.nbVSquare ? _gridModel.nbVSquare - 1 : _gridModel.focusY + y
			);
			
			_gridModel.dispatchEvent(new GridFocusEvent(GridFocusEvent.FOCUS));
			  
		 }
		 
	}
}