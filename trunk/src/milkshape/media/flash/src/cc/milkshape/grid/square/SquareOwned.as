package cc.milkshape.grid.square
{
	public class SquareOwned extends Square
	{
		private var _user:Object;
		public function SquareOwned(x:int, y:int, color:int, size:int)
		{
			super(x, y, color, size);
		}

		public function get user():Object
		{
			return _user;
		}

		public function set user(v:Object):void
		{
			_user = v;
		}

	}
}