package grid
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import grid.square.Square;
	import grid.square.SquareBooked;
	import grid.square.SquareFull;

	public class Grid extends MovieClip
	{
		private var _nbSquareX:int;
		private var _nbSquareY:int;
		private var _minX:int = 0;
		private var _minY:int = 0;
		private var _maxX:int = 0;
		private var _maxY:int = 0;
		private var _lstPosition:Array;
		
		public function Grid(squares:Array)
		{		
			for each(var square:Object in squares)
			{
				if(square.status)// if the square is full
				{
					var squareObject:Square = new SquareFull(square.pos_x, square.pos_y);
				}
				else
				{
					var squareObject:Square = new SquareBooked(square.pos_x, square.pos_y);
					
				}
				addChild(squareObject);
			}
			
					
		}
		
		public static function getPositions():Array
		{
			if(!(_lstPosition is Array))
			{
				_lstPosition = new Array();
				var i:int;
				for(i = 0 ; i < _maxY ; ++i)
				{
					_lstPosition.push(new Array());
				}
				
				var x:int;
				var y:int;
				var ind:int;
				var square:Square;
				var squares:Array = SquareManager.getSquares();
				for(i = 0 ; i < squares.length ; ++i)
				{
					x = square.X + _minX * -1;
					y = square.Y + _minY * -1;
					
					square = squares[i];
					_lstPosition[x][y] = i;
					
					if(square is SquareBooked)
					{
						for(var j:int = 0 ; j < Constance.posX.length ; ++j)
						{
							new SquareDisable(x + Constance.posX[j], y + Constance.posY[j]);
							
							_lstPosition[x + Constance.posX[j]][y + Constance.posY[j]] = SquareManager.length() - 1;					
						}
					}
					else if(square is SquareFull)
					{
						
					}
				}
				
				
					
			}
			
			return _lstPosition;
		}
	
		
		private function _createOtherSquares():void
		{
			// we need to create open square
			var squares: Array = SquareManager.getSquare
			
			// 
		}
		
		private function _init():void
		{
			var stageWidth:int = 960;
			var stageHeight:int = 600;
			
			/*if(_nbColumn > _nbLine)
			{
				width = stageWidth;
				scaleY = scaleX;
			}
			else
			{
				height = stageHeight;
				scaleX = scaleY;
			}
			*/
		}
		
		private function _scroll(e:MouseEvent):void
		{
			scaleX *= 2;
			scaleY *= 2;
		}
		
	}
	
}