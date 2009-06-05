package cc.milkshape.grid
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class GridBackground extends Sprite
	{
		public function GridBackground()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function _init(e:Event):void {
			graphics.beginFill(0x000000,0);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
	}
}