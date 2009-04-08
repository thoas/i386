package src.grid.square 
{
	import flash.display.Shape;
	
	public class Square extends Shape
	{
		public function Square(px:int, py:int, w:int = 800, h:int = 800) 
		{
			graphics.beginFill(Math.random() * 0xFFFFFF);
			graphics.drawRect(px*w, py*h, w, h);
			graphics.endFill();
			SquareManager.add(this);
		}
		
	}
	
}