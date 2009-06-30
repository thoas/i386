package cc.milkshape.home
{
	import cc.milkshape.account.ProfileController;
	import cc.milkshape.account.events.ProfilesEvent;
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.home.*;
	import cc.milkshape.issue.IssueController;
	import cc.milkshape.issue.events.IssuesEvent;
	import cc.milkshape.preloader.PreloaderWiper;
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.utils.Constance;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

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
			_profileController.addEventListener(ProfilesEvent.LAST_PROFILES, _loadProfiles);
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

			_currentIssues = new HomeCurrentIssuesClp();
			_completeIssue = new HomeCompleteIssueClp();
			_lastArtists = new HomeLastArtists();
			
			_header = new PreloaderWiper();
			_header.loadMedia(HEADER_IMG_URL);
				
			_welcomeText = new WelcomeText();
            
			_mask = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, stage.stageWidth, 402);
			_mask.graphics.endFill();
			_header.mask = _mask;
			
			addChild(_header);
			addChild(_welcomeText);
			addChild(_currentIssues);
			addChild(_completeIssue);

			_issueController.lastIssues();
			_profileController.lastProfiles();
			
			_welcomeText.moreInfoBtn.buttonMode = true;
			_welcomeText.moreInfoBtn.addEventListener(MouseEvent.CLICK, _moreInfoClick);
			
			_placeElements();
		}
		
		private function _moreInfoClick(e:MouseEvent):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {
				url: Constance.ABOUT_SWF
			}));
		}
		
		private function _placeElements():void
		{
			_lastArtists.y = _currentIssues.y = _completeIssue.y = 370;
			_currentIssues.x = 38;
			_completeIssue.x = 520;
			_lastArtists.x = 768;
			_welcomeText.y = 28;
            _welcomeText.x = 520;
		}
		
		private function _loadProfiles(e:ProfilesEvent):void
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
			_currentIssues.allIssues.addChild(new SmallButton("ALL ISSUES", new PlusItem()));
			
			if(o.complete_issues.length > 0)
			{
				_completeIssue.preview1.addChild(new HomeIssuePreview(o.complete_issues[0]));	
			}
			_completeIssue.allIssues.addChild(new SmallButton("ALL ISSUES", new PlusItem()));
			
			_currentIssues.allIssues.addEventListener(MouseEvent.CLICK, _handlerClick);
			_completeIssue.allIssues.addEventListener(MouseEvent.CLICK, _handlerClick);
		}
		
		private function _handlerClick(e:MouseEvent):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {
				url: Constance.ISSUES_SWF, posX:0
			}));
		}
		
		private function _handlerResize(e:Event):void
		{
			_mask.width = stage.stageWidth;
		}
	}
	
}