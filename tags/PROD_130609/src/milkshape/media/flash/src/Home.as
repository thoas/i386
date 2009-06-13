package
{
	import cc.milkshape.home.*;
	import cc.milkshape.preloader.PreloaderWiper;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Home extends MovieClip
	{
		private var _header:PreloaderWiper;
		private var _mask:Sprite;
		private var _welcomeText:WelcomeText;
		private var _currentIssues:HomeCurrentIssuesClp;
		private var _completeIssue:HomeCompleteIssueClp;
		private var _lastArtists:HomeLastArtistsClp;
		
		public function Home()
		{
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			var oGateway:Object = {
				header_url: 'assets/bg.jpg',
				current1: {url: 'assets/currentissue1.jpg', title: 'BLACK & WHITE', info: 'sdfljsdflsdfmlkdfj, dsfmsdfsdfmsldf'},
				current2: {url: 'assets/currentissue2.jpg', title: 'OVER THE LAND', info: 'sdlfjjpfj sdfj s'},
				complete1: {url: 'assets/completeissue1.jpg', title: 'GENERATION 80', info: 'sdlfjjpfj sdfj s'}
			};
			
			_onResult(oGateway);
			
		}
		
		private function _onResult(o:Object):void
		{
			stage.addEventListener(Event.RESIZE, _handlerResize);
			
			_header = new PreloaderWiper();
			_header.loadMedia(o.header_url);
				
			_welcomeText = new WelcomeText();
            _welcomeText.y = 80;
            
			_currentIssues = new HomeCurrentIssuesClp();
			_currentIssues.preview1.addChild(new HomeIssuePreview(o.current1));
			_currentIssues.preview2.addChild(new HomeIssuePreview(o.current2));
			_currentIssues.x = 30;
			
			_completeIssue = new HomeCompleteIssueClp();
			_completeIssue.preview1.addChild(new HomeIssuePreview(o.complete1));
			_completeIssue.x = _currentIssues.width + 80;
			
			_lastArtists = new HomeLastArtistsClp();
			_lastArtists.x = _completeIssue.x + _completeIssue.width + 50;
			
			_mask = new Sprite();
			_header.mask = _mask;
			
			addChild(_header);
			addChild(_welcomeText);
			addChild(_currentIssues);
			addChild(_completeIssue);
			addChild(_lastArtists);
			
			_handlerResize(null);		
		}
		
		private function _handlerResize(e:Event):void
		{			
			_mask.graphics.clear();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, stage.stageWidth, Math.round(stage.stageHeight/2));
			_mask.graphics.endFill();
			
			_welcomeText.x = stage.stageWidth - 504;
			
			_currentIssues.y = _completeIssue.y = _lastArtists.y = _mask.height + 30;
		}
	}
	
}