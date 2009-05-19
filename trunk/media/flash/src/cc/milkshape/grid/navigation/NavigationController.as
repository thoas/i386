package grid.navigation
{
	import grid.Grid;
	
	public class NavigationController
	{
		private var _grid:Grid;
		
		public function NavigationController(grid:Grid)
		{
			_grid = grid;
			_grid.scaleX = _grid.scaleY = 0.2;
		}

	}
}