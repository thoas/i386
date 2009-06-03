package cc.milkshape.utils
{
	public class Calcul
	{
		public static function randRange(min:Number, max:Number):Number
		{
			return Math.floor( Math.random() * ( max - min + 1 ) ) + min;
		}

	}
}