package
{
	import cc.milkshape.grid.GridController;
	import cc.milkshape.grid.GridModel;
	import cc.milkshape.grid.GridView;
	import cc.milkshape.grid.square.SquareFormEvent;
	import cc.milkshape.preloader.PreloaderEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='960', height='600', frameRate='31', backgroundColor='#141414')]
	
	public class Issue extends Sprite
	{		
		public function Issue()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			stage.stageFocusRect = false;
			loaderInfo.sharedEvents.addEventListener(PreloaderEvent.INFO, _handlerInit);
		}
		
		private function _handlerInit(e:PreloaderEvent = null):void
		{
			var gridModel:GridModel = new GridModel(int(e.msg));
			var gridController:GridController = new GridController(gridModel);
			var gridView:GridView = new GridView(gridModel, gridController);

			gridModel.addEventListener(SquareFormEvent.SHOW_OPEN, _showOpenForm);
			gridModel.addEventListener(SquareFormEvent.SHOW_BOOKED, _showBookedForm);
			gridModel.addEventListener(SquareFormEvent.CLOSE, _closeForm);
			
			addChild(gridView);
		}
		/*
		import flash.events.TimerEvent;
		import flash.utils.Timer;
		private var _showSquareTimer:Timer;
		_showSquareTimer = new Timer(2000, 1);
		_showSquareTimer.stop();
		if(_currentScale == _maxScale)
		{
			var square:Square = _controller.getFocusSquare();
			if(square is SquareOpen)
			{
				_showSquareTimer.removeEventListener('timer', _showSquareBooked);
        		_showSquareTimer.addEventListener('timer', _showSquareOpen);
        		_showSquareTimer.start();
			}
			else if(square is SquareBooked)
			{
				_showSquareTimer.removeEventListener('timer', _showSquareOpen);
        		_showSquareTimer.addEventListener('timer', _showSquareBooked);
        		_showSquareTimer.start();
			}
		}
		*/
		private function _showOpenForm(e:SquareFormEvent):void
		{
			trace('show open');
		}
		
		private function _showBookedForm(e:SquareFormEvent):void
		{
			trace('show booked');
		}
		
		private function _closeForm(e:SquareFormEvent):void
		{
			trace('close');
		}
	}
}