package
{
	import flash.display.MovieClip;
	import grid.Grid;
	
	[SWF(width='960', height='600', frameRate='30', backgroundColor='#ffffff')]
	
	public class grid extends MovieClip
	{
		private var _grid:Grid;
		
		public function grid(nbColumn:int = 10, nbLine:int = 5)
		{
			_grid = new Grid(nbColumn, nbLine);
			addChild(_grid);
		}	
	}
}