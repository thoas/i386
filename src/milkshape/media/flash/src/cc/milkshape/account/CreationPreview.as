package cc.milkshape.account
{
	import cc.milkshape.account.events.CreationPreviewEvent;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.buttons.UnderlineButton;
	import cc.milkshape.preloader.PreloaderKb;
	
	import flash.events.MouseEvent;

	public class CreationPreview extends CreationPreviewClp
	{
		private var _url:String;
		private var _posX:int;
		private var _posY:int;
		private var _date:Date;
		private var _issueSlug:String;
		private var _viewIssue:SmallButton;
		private var _enabledCancel:Boolean;
		private var _cancel:UnderlineButton;
		public function CreationPreview($title:String, $date:Date, $info:String, $posX:int, $posY:int, $issueSlug:String, $enabledCancel:Boolean=false, $url:String=null)
		{
			title.text = $title;
			date.text = $date.toDateString();
			info.text = $info;
			_enabledCancel = $enabledCancel;
			_date = $date;
			_url = $url;
			_posX = $posX;
			_posY = $posY;
			_issueSlug = $issueSlug;
			
			if(_url){
				var img:PreloaderKb = new PreloaderKb();
				img.loadMedia(_url);
				preview.addChild(img);
			} else {
				preview.addChild(new EmptyThumbClp());
			}
			
			_viewIssue = new SmallButton('VIEW IN ISSUE', new PlusItem());
			_viewIssue.addEventListener(MouseEvent.CLICK, _goToIssueHandler);
			goTo.addChild(_viewIssue);
			
			if(_enabledCancel)
			{
				_cancel = new UnderlineButton('CANCEL RESERVATION');
				_cancel.addEventListener(MouseEvent.CLICK, _cancelHandler);
				cancel.addChild(_cancel);
			}
		}
		
		private function _cancelHandler(e:MouseEvent):void
		{
			dispatchEvent(new CreationPreviewEvent(CreationPreviewEvent.CANCEL_CLICKED, _posX, _posY, _issueSlug));
		}

		public function get issueSlug():String
		{
			return _issueSlug;
		}

		public function set issueSlug(v:String):void
		{
			_issueSlug = v;
		}

		public function get posY():int
		{
			return _posY;
		}

		public function set posY(v:int):void
		{
			_posY = v;
		}

		public function get posX():int
		{
			return _posX;
		}

		public function set posX(v:int):void
		{
			_posX = v;
		}
		
		private function _goToIssueHandler(e:MouseEvent):void
		{
			/*
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {
				url: Constance.ISSUE_SWF, 
				background: false,
				posX: Constance.ISSUE_POSX, 
				posY: Constance.ISSUE_POSY,  
				params: {slug: _issueSlug, focusX: _posX, focusY: _posY}
			}));*/
		}

	}
}