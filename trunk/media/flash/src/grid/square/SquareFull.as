package grid.square
{
	public class SquareFull extends Square
	{
		private var _background:String;
		public function SquareFull(x:int, y:int, background:String, w:int, h:int)
		{
			_background = background;
			super(x, y, 0x000000, w, h);
		}
		
	}
}