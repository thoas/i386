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