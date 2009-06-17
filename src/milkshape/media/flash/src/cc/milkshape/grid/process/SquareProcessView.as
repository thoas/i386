package cc.milkshape.grid.process
{
	import cc.milkshape.utils.BigButton;

	public class SquareProcessView extends SquareProcessClp
	{
		private var _squareProcessController:SquareProcessController;
		private var _bookBtn:BigButton;
		private var _downloadBtn:BigButton;
		private var _cancelBtn:BigButton;
		private var _uploadBtn:BigButton;
		private var _feedbackBtn:BigButton;
		
		public function SquareProcessView(o:SquareProcessController)
		{
			stop();
			
			_squareProcessController = o;
			
			_bookBtn = new BigButton('Réserver', new CirclePlusItem());
			_cancelBtn = new BigButton('Annuler', new CircleCrossItem());
		 	_downloadBtn = new BigButton('Télécharger', new CircleArrowDownItem());
			_uploadBtn = new BigButton('Upload', new CircleArrowUpItem());
			_feedbackBtn = new BigButton('OK', new CirclePlusItem());

			bookBtn.addChild(_bookBtn);
			cancelBtn.addChild(_cancelBtn);
			downloadBtn.addChild(_downloadBtn);
			uploadBtn.addChild(_uploadBtn);
			feedbackBtn.addChild(_feedbackBtn);
		}
	}
}