package src
{
	import flash.display.MovieClip;
	import src.grid.Grid;
	
	public class Main extends MovieClip
	{
		private var _grid:Grid;
		
		public function Main()
		{
			_grid = new Grid(10, 10);
			_grid.scroll(-5);
			addChild(_grid);
			
			
		}
	}
	
}