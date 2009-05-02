package grid
{
	import flash.display.Shape;
	
	public class GridLine extends Shape
	{
		public function GridLine(nbHorizontalLine:int, nbVerticalLine:int, width:int, height:int,lineColor:int = 0x00000, lineWidth:int = 0):void
		{
            graphics.lineStyle(lineWidth, lineColor);// mémo : LineScaleMode.VERTICAL
           
            for(var i:int = 0; i <= nbVerticalLine; i++)
  			{
  				graphics.lineTo(i * height, height * nbVerticalLine);
            	graphics.moveTo((i+1) * height, 0);
 			}
 			
 			graphics.moveTo(0, 0);
 			
            for(var j:int = 0; j <= nbHorizontalLine; j++)
  			{
  				graphics.lineTo(width * nbHorizontalLine, j * width);
            	graphics.moveTo(0, (j+1) * width);
  			}
		}

	}
}