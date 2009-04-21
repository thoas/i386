package mvc
{
	import mvc.SquareEvent;
	public class GridModel extends EventDispatcher 
	{
		private var _issueId:int;
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		private var _lstPosition:Vector.<Array>;
	
		public function GridModel(issueId:int) 
		{ 
			_issueId = issueId;
			 var gridModel:GridModel = new GridModel(issueId); 
			 var gridController:GridController = new GridController(gridModel); 
			 var gridView:GridView = new GridView(gridModel, gridController, this.stage); 
		}
		
		public function get issueId():int
		{
			return _issueId;
		}	
		
		public function setPosition(squares:Array, squaresOpen:Array, minX:int, minY:int, maxX:int, maxY:int)
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
		}
		
		private function _addPosition(square:Square):void
		{
			var ind:int = SquareManager.length() - 1;
			_lstPosition[square.X + _minX * -1][square.Y + _minY * -1] = ind;
			dispatchEvent(SquareEvent(SquareEvent.SQUARE_CREATION, square));
		}
	}
}