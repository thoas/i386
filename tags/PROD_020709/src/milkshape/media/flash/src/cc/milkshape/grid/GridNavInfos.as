package cc.milkshape.grid
{
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Sine;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GridNavInfos extends NavInfosClp
	{
		public function GridNavInfos()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _handlerRemovedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			addEventListener(MouseEvent.ROLL_OVER, _handlerOver);
			
			stage.addEventListener(Event.RESIZE, _handlerResize);
			
			_handlerResize(null);
			
			new GTween(
				this, 
				0.2, {
				alpha: 0.01 }, {
				ease:Sine.easeOut, delay: 6, completeListener: _init}
			);
		}
		
		private function _init(e:Event):void
		{
			addEventListener(MouseEvent.ROLL_OUT, _handlerOut);
		}
		
		private function _handlerOver(e:MouseEvent):void
		{
			new GTween(
				this, 
				0.2, {
				alpha: 1 }, {
				ease:Sine.easeOut}
			);
		}
		
		private function _handlerOut(e:MouseEvent):void
		{
			new GTween(
				this, 
				0.2, {
				alpha: 0.01 }, {
				ease:Sine.easeOut}
			);
		}
		
		private function _handlerRemovedToStage(e:Event):void
		{
			removeEventListener(MouseEvent.MOUSE_OVER, _handlerOver);
			removeEventListener(MouseEvent.MOUSE_OUT, _handlerOut);
			stage.removeEventListener(Event.RESIZE, _handlerResize);
		}
		
		private function _handlerResize(e:Event):void
		{
			y = stage.stageHeight - 120/*50 - 37 - 23*/;
			bg.width = stage.stageWidth;
			clip.x = Math.round(stage.stageWidth * 0.5 - clip.width * 0.5);
		}
	}
}