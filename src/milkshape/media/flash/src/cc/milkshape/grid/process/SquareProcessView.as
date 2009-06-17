package cc.milkshape.grid.process
{
	import cc.milkshape.utils.buttons.BigButton;
	import cc.milkshape.grid.process.events.SquareProcessEvent;
	import cc.milkshape.grid.GridModel;
	import flash.events.MouseEvent;
	import com.gskinner.motion.GTween;
	import fl.motion.easing.Sine;
	import cc.milkshape.grid.square.events.SquareFormEvent;

	public class SquareProcessView extends SquareProcessClp
	{
		private var _squareProcessController:SquareProcessController;
		private var _gridModel:GridModel;
		private var _bookBtn:BigButton;
		private var _templateBtn:BigButton;
		private var _releaseBtn:BigButton;
		private var _fillBtn:BigButton;
		private var _reloadBtn:BigButton;
		
		public function SquareProcessView(gridModel:GridModel, o:SquareProcessController)
		{
			_squareProcessController = o;
			_gridModel = gridModel;
			
			_bookBtn = new BigButton('Reserver', new CirclePlusItem());
			_releaseBtn = new BigButton('Annuler', new CircleCrossItem());
		 	_templateBtn = new BigButton('Telecharger', new CircleArrowDownItem());
			_fillBtn = new BigButton('Upload', new CircleArrowUpItem());
			_reloadBtn = new BigButton('OK', new CirclePlusItem());
			 
			_bookBtn.addEventListener(MouseEvent.CLICK, _book);
			_releaseBtn.addEventListener(MouseEvent.CLICK, _release);
			_templateBtn.addEventListener(MouseEvent.CLICK, _template);
			_fillBtn.addEventListener(MouseEvent.CLICK, _fill);
			_reloadBtn.addEventListener(MouseEvent.CLICK, _reload);
			
			_squareProcessController.addEventListener(SquareProcessEvent.DOWNLOAD, _download);	
			_squareProcessController.addEventListener(SquareProcessEvent.UPLOADING, _uploading);
			_squareProcessController.addEventListener(SquareProcessEvent.SUCCESS, _success);	
			_squareProcessController.addEventListener(SquareProcessEvent.CANCELED, _canceled);	
			_squareProcessController.addEventListener(SquareProcessEvent.BOOKED, _booked);	
			
			_gridModel.addEventListener(SquareFormEvent.SHOW_OPEN, _showOpenForm);
			_gridModel.addEventListener(SquareFormEvent.SHOW_BOOKED, _showBookedForm);
			_gridModel.addEventListener(SquareFormEvent.CLOSE, _closeForm);		
			
			bookBtn.addChild(_bookBtn);
			releaseBtn.addChild(_releaseBtn);
			templateBtn.addChild(_templateBtn);
			fillBtn.addChild(_fillBtn);
			reloadBtn.addChild(_reloadBtn);
		}
		
		private function _download(e:SquareProcessEvent):void
		{
			// UPLOAD ENABLE
		}
		
		private function _uploading(e:SquareProcessEvent):void
		{
			gotoAndPlay('uploading');
		}
		
		private function _canceled(e:SquareProcessEvent):void
		{
			bookBtn.addChild(_bookBtn);
			gotoAndPlay('open');
		}
		
		private function _booked(e:SquareProcessEvent):void
		{
			gotoAndPlay('booked');
		}
		
		private function _success(e:SquareProcessEvent):void
		{
			gotoAndPlay('success');
		}
		
		private function _book(e:MouseEvent):void
		{
			_squareProcessController.book();
		}
		
		private function _release(e:MouseEvent):void
		{
			_squareProcessController.release();
		}
		
		private function _template(e:MouseEvent):void
		{
			_squareProcessController.template();
		}
		
		private function _fill(e:MouseEvent):void
		{
			_squareProcessController.fill();
		}
		
		private function _reload(e:MouseEvent):void
		{
			_squareProcessController.reload();
		}
		
		private function _showOpenForm(e:SquareFormEvent):void
		{
			new GTween(
				this, 
				0.1, 
				{ alpha: 1 }, 
				{ ease:Sine.easeOut }
			);
			
			trace('show open');
		}
		
		private function _showBookedForm(e:SquareFormEvent):void
		{
			trace('show booked');
		}
		
		private function _closeForm(e:SquareFormEvent):void
		{
			new GTween(
				this, 
				0.1, 
				{ alpha: 0 }, 
				{ ease:Sine.easeOut }
			);
		}
	}
}