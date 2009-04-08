package src.grid
{
	import flash.display.MovieClip;
	import src.grid.square.Square;
	
	public class Grid extends MovieClip
	{
		private var _nbColumn:int;
		private var _nbLine:int;
		
		public function Grid(nbColumn:int, nbLine:int)
		{
			for (var i:int = 0; i < nbLine; i++)
			{
				for (var j:int = 0; j < nbColumn; j++)
				{
					addChild(new Square(i, j));
				}
			}

		}
		
		public function scroll(level:int)
		{
			
		}
		
	}
	
}