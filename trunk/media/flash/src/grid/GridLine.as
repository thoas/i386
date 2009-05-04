package grid
{
	import flash.display.Shape;
	
	public class GridLine extends Shape
	{
		public function GridLine(nbHorizontalLine:int, nbVerticalLine:int, size:int, lineColor:int = 0x00000, lineWidth:int = 0):void
		{
            graphics.lineStyle(lineWidth, lineColor);// mémo : LineScaleMode.VERTICAL
           
            for(var i:int = 0; i <= nbVerticalLine; i++)
  			{
  				graphics.lineTo(i * size, size * nbVerticalLine);
            	graphics.moveTo((i+1) * size, 0);
 			}
 			
 			graphics.moveTo(0, 0);
 			
            for(var j:int = 0; j <= nbHorizontalLine; j++)
  			{
  				graphics.lineTo(size * nbHorizontalLine, j * size);
            	graphics.moveTo(0, (j+1) * size);
  			}
		}

	}
}