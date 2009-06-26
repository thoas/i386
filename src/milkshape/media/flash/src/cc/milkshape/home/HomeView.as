package cc.milkshape.home
{
	import cc.milkshape.account.ProfileController;
	import cc.milkshape.account.events.ProfileEvent;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.home.*;
	import cc.milkshape.issue.IssueController;
	import cc.milkshape.issue.events.IssuesEvent;
	import cc.milkshape.preloader.PreloaderWiper;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	public class HomeView extends MovieClip
	{
		private static const HEADER_IMG_URL:String = 'assets/bg.jpg';
		private var _issueController:IssueController;
		private var _profileController:ProfileController;
		private var _header:PreloaderWiper;
		private var _mask:Sprite;
		private var _welcomeText:WelcomeText;
		private var _currentIssues:HomeCurrentIssuesClp;
		private var _completeIssue:HomeCompleteIssueClp;
		private var _lastArtists:HomeLastArtists;
		
		public function HomeView(issueController:IssueController, profileController:ProfileController):void
		{
			_issueController = issueController;
			_profileController = profileController;
			_issueController.addEventListener(IssuesEvent.LAST_ISSUES_LOADED, _loadIssues);
			_profileController.addEventListener(ProfileEvent.LAST_PROFILES, _loadProfiles);
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _handlerRemovedFromStage);
		}
		
		private function _handlerRemovedFromStage(e:Event):void
		{
			stage.removeEventListener(Event.RESIZE, _handlerResize);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			stage.addEventListener(Event.RESIZE, _handlerResize);
			
			_lastArtists = new HomeLastArtists();
			_currentIssues = new HomeCurrentIssuesClp();
			_completeIssue = new HomeCompleteIssueClp();
			_header = new PreloaderWiper();
			_header.loadMedia(HEADER_IMG_URL);
				
			_welcomeText = new WelcomeText();
            _welcomeText.y = 80;
			
			_mask = new Sprite();
			_header.mask = _mask;
			
			addChild(_header);
			addChild(_welcomeText);
			addChild(_currentIssues);
			addChild(_completeIssue);
			
			_handlerResize(null);	
			_issueController.lastIssues();
			_profileController.lastProfiles();
		}
		
		private function _loadProfiles(e:ProfileEvent):void
		{
			_lastArtists.init(e.lastProfiles);
			addChild(_lastArtists);
		}
		
		private function _loadIssues(e:IssuesEvent):void
		{
			var o:Object = e.lastIssues;
			if(o.current_issues.length > 0)
			{
				_currentIssues.preview1.addChild(new HomeIssuePreview(o.current_issues[0]));
				if(o.current_issues.length > 1)
					_currentIssues.preview2.addChild(new HomeIssuePreview(o.current_issues[1]));	
			}
			_currentIssues.x = 37;
			_currentIssues.allIssues.addChild(new SmallButton("ALL ISSUES", new PlusItem()));
			
			if(o.complete_issues.length > 0)
			{
				_completeIssue.preview1.addChild(new HomeIssuePreview(o.complete_issues[0]));	
			}
			_completeIssue.x = _currentIssues.x + _currentIssues.width;
			_completeIssue.allIssues.addChild(new SmallButton("ALL ISSUES", new PlusItem()));
			
			_lastArtists.x = _completeIssue.x + _completeIssue.width;
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