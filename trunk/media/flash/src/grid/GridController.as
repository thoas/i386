package grid
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import grid.square.Square;
	import grid.square.SquareEvent;
	import grid.square.SquareManager;
	
	import utils.Constance;
	
	public class GridController
	{
		private var _gridModel:GridModel;
		private var _overX:int;
		private var _overY:int;
		
		public function GridController(gridModel:GridModel)
		{
			_gridModel = gridModel;
		}
		
		public function getData(event:Event = null):Boolean
		{
			var issueId:int = _gridModel.issueId;
			
			// On envoit une requête en POST avec issue_id
			// On reçoit des beaux modèles hots.
			var sq1:Object = new Object();
			sq1.pos_x = 0;
			sq1.pos_y = 0;
			sq1.background_image_path = 'jeanjack/209320372038';
			sq1.status = 1;
			
			var sq2:Object = new Object();
			sq2.pos_x = 1;
			sq2.pos_y = 0;
			sq2.background_image_path = 'jeanjack/209320372038';
			sq2.status = 1;
			
			var sq3:Object = new Object();
			sq3.pos_x = 1;
			sq3.pos_y = -1;
			sq3.background_image_path = null;
			sq3.status = 0;
			
			var sq4:Object = new Object();
			sq4.pos_x = 1;
			sq4.pos_y = 1;
			sq4.background_image_path = null;
			sq4.status = 0;
			
			var sqo1:Object = new Object();
			sqo1.pos_x = -1;
			sqo1.pos_y = -1;
			
			var sqo2:Object = new Object();
			sqo2.pos_x = -1;
			sqo2.pos_y = 0;
			
			var sqo3:Object = new Object();
			sqo3.pos_x = -1;
			sqo3.pos_y = 1;
			
			var issue:Object = new Object();
			issue.title = 'Bac à sable';
			issue.text_presentation = 'Bac à sable desc';
			issue.nb_square_x = 0;
			issue.nb_square_y = 0;
			issue.show_disable_square = 0;
			issue.max_participation = 1;
			issue.squares = new Array(sq1, sq2, sq3, sq4);
			issue.squares_open = new Array(sqo1, sqo2, sqo3);
			issue.min_x = -1;
			issue.max_x = 1;
			issue.min_y = -1;
			issue.max_y = 1;
			issue.square_size = 800;
			
			_gridModel.init(issue.squares, issue.squares_open, issue.min_x, issue.min_y, issue.max_x, issue.max_y, issue.nb_square_x, issue.nb_square_y, issue.show_disable_square, issue.square_size);
			
			return true;
		}
		
		public function mouseWheel(mouseEvent:MouseEvent):void
		{
			_gridModel.focusX = _overX;
			_gridModel.focusY = _overY;
			_gridModel.dispatchEvent(new GridEvent(GridEvent.GRID_PUT_FOCUS));
			zoomTo(Math.round(mouseEvent.delta/4));
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
			return scales;
		}
		
		public function zoomTo(op:int):void
		{
			var futurScale:int = _gridModel.currentScale + op < _gridModel.minScale ? _gridModel.minScale : _gridModel.currentScale + op > _gridModel.maxScale ? _gridModel.maxScale : _gridModel.currentScale + op;
			
			if(_gridModel.currentScale != futurScale)// Si le zoom change
			{
				_gridModel.currentScale = futurScale;
				_gridModel.dispatchEvent(new GridEvent(GridEvent.GRID_MOVE));
			}
		}
		
		public function onClick(mouseEvent:MouseEvent):void
		{
			_gridModel.focusX = _overX;
			_gridModel.focusY = _overY;
			zoomTo(mouseEvent.shiftKey ? -1 : 1);	
		}
		
		private function _squareMoveTo(X:int, Y:int):void
		{
			_gridModel.focusX = _gridModel.focusX + X < 0 ? 0 : _gridModel.focusX + X >= _gridModel.nbHSquare ? _gridModel.nbHSquare - 1 : _gridModel.focusX + X;
			_gridModel.focusY = _gridModel.focusY + Y < 0 ? 0 : _gridModel.focusY + Y >= _gridModel.nbVSquare ? _gridModel.nbVSquare - 1 : _gridModel.focusY + Y;
			_gridModel.dispatchEvent(new GridEvent(GridEvent.GRID_PUT_FOCUS));	
		}
		
		public function getFocusSquare():Square
		{
			return SquareManager.get(_gridModel.focusSquare);
		}
		
		public function squareFocus(e:SquareEvent):void
		{
			_gridModel.focusX = e.square.X;
			_gridModel.focusY = e.square.Y;
			
			if(_gridModel.currentScale != _gridModel.minScale)// Si on n'est pas au zoom minimal
			{
				_gridModel.dispatchEvent(new GridEvent(GridEvent.GRID_MOVE));
			}
		}
		
		public function squareOver(e:SquareEvent):void
		{
			_overX = e.square.X;
			_overY = e.square.Y;
		}
		
		public function onDoubleClick(mouseEvent:MouseEvent):void
		{
			zoomTo(mouseEvent.shiftKey ? -_gridModel.maxScale : _gridModel.maxScale);
		}
		
		public function keyDownHandler(e:KeyboardEvent):void
		{
			var boost:int = e.shiftKey ? 2 : 1;
			
			switch(e.keyCode)
			{
				case Keyboard.UP:
				case 87: // W
					_squareMoveTo(0, -1 * boost);
					break;

				case Keyboard.DOWN:
				case 83: // S
					_squareMoveTo(0, 1 * boost);
					break;

				case Keyboard.LEFT:
				case 65: // A
					_squareMoveTo(-1 * boost, 0);
					break;

				case Keyboard.RIGHT:
				case 68: // D
					_squareMoveTo(1 * boost, 0);
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
		 }
	}
}