package grid
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import grid.square.Square;
	import grid.square.SquareManager;
	
	public class Grid extends MovieClip
	{
		private var _nbColumn:int;
		private var _nbLine:int;
		
		public function Grid(nbColumn:int = 10, nbLine:int = 5)
		{
			
			new SquareManager(nbColumn, nbLine);
			_nbColumn = nbColumn;
			_nbLine = nbLine;
			
			for (var i:int = 0; i < _nbColumn; i++)
			{
				for (var j:int = 0; j < _nbLine; j++)
				{
					addChild(new Square(i, j));
				}
			}
			
			addEventListener(MouseEvent.CLICK, _scroll);
			
			_init();
		}
		
		private function _init():void
		{
			var stageWidth:int = 960;
			var stageHeight:int = 600;
			
			if(_nbColumn > _nbLine)
			{
				width = stageWidth;
				scaleY = scaleX;
				
			}
			else
			{
				height = stageHeight;
				scaleX = scaleY;
			}
			
		}
		
		private function _scroll(e:MouseEvent):void
		{
			scaleX *= 2;
			scaleY *= 2;
		}
		
	}
	
}