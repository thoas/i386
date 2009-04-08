package src.grid.square 
{
	import flash.display.Shape;
	
	public class Square extends Shape
	{
		// scale : 26px, 78px, 182px, 416px, 800px (max 1024 Square pour écran 840*840px)
		// pos : le premier (0, 0)
		
		public function Square(px:int, py:int, w:int = 800, h:int = 800) 
		{
			graphics.beginFill(Math.random() * 0xFFFFFF);
			graphics.drawRect(px*w, py*h, w, h);
			graphics.endFill();
			SquareManager.add(this);
		}
		
	}
	
}