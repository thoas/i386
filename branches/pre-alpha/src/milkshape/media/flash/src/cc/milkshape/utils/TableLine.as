package cc.milkshape.utils
{
	import flash.display.Shape;
	
	public class TableLine extends Shape
	{
		public function TableLine(w:int, h:int, vSpace:int, hSpace:int, lineColor:int = 0x000000, lineWidth:int = 1):void
		{
			var nbHorizontalLine:int = Math.round(h/vSpace);
			var nbVerticalLine:int = Math.round(w/hSpace);
			
            graphics.lineStyle(lineWidth, lineColor);// mémo : LineScaleMode.VERTICAL
            
            for(var i:int = 0; i <= nbVerticalLine; i++)
  			{
  				graphics.lineTo(i * hSpace, vSpace * nbHorizontalLine);
            	graphics.moveTo((i+1) * hSpace, 0);
 			}
 			
 			graphics.moveTo(0, 0);
 			
            for(var j:int = 0; j <= nbHorizontalLine; j++)
  			{
  				graphics.lineTo(hSpace * nbVerticalLine, j * vSpace);
            	graphics.moveTo(0, (j+1) * vSpace);
  			}
		}

	}
}