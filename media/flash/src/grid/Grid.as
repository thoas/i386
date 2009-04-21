package grid
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import grid.navigation.NavigationController;
	import grid.square.Square;
	import grid.square.SquareBooked;
	import grid.square.SquareFull;
	import grid.square.SquareManager;
	import grid.square.SquareOpen;

	public class Grid extends MovieClip
	{
		private var _navigationController:NavigationController;
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		private var _lstPosition:Vector.<Array>;
		
		public function Grid(squares:Array, squaresOpen:Array, minX:int, minY:int, maxX:int, maxY:int)
		{		
			_minX = minX < _minX ? minX:0;
			_minY = minY < _minY ? minX:0;
			_maxX = maxX;
			_maxY = maxY;
			var i:int;
			var ind:int;
			_lstPosition = new Vector.<Array>(_maxX - _minX + 1);
			for(i = 0 ; i <= _maxY + 1 ; ++i)
			{
				_lstPosition[i] = new Array(_maxY - _minY + 1);
			}
			var square:Object;
			for each(square in squares)
			{
				_addPosition(square.status ? 
						new SquareFull(square.pos_x, square.pos_y, square.background_image_path)
					 	: new SquareBooked(square.pos_x, square.pos_y));
			}
			
			for each(square in squaresOpen)
			{
				_addPosition(new SquareOpen(square.pos_x, square.pos_y));
			}
			
			addEventListener(Event.ADDED_TO_STAGE, _init);		
		}
		
		private function _init(e:Event):void
		{
			_navigationController = new NavigationController(this);
		}
		
		private function _addPosition(square:Square):void
		{
			addChild(square);
			var ind:int = SquareManager.length() - 1;
			trace(square.X + _minX * -1 + ";" + (square.Y + _minY * -1) + " : " + typeof(square));
			_lstPosition[square.X + _minX * -1][square.Y + _minY * -1] = ind;
		}
	}
	
}