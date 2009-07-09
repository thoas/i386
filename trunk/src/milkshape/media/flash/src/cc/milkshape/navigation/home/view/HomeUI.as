package cc.milkshape.navigation.home.view
{
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.navigation.generic.PrivateEventList;
	import cc.milkshape.navigation.generic.UIList;
	import cc.milkshape.preloader.PreloaderWiper;
	
	import com.bourre.events.BasicEvent;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.ObjectEvent;
	import com.bourre.ioc.bean.BeanFactory;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class HomeUI extends AbstractView
	{
		private var _header:PreloaderWiper;
		private var _mask:Sprite;
		private var _welcomeText:WelcomeTextUI;
		private var _currentIssues:HomeCurrentIssuesClp;
		private var _completeIssue:HomeCompleteIssueClp;
		private var _lastArtists:HomeLastArtistsUI;
		
		public function HomeUI(owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
			view.addEventListener(Event.ADDED_TO_STAGE, _initUI);
			view.addEventListener(Event.REMOVED_FROM_STAGE, _removedFromStageHandler);
		}
		
		private function _removedFromStageHandler(e:Event):void
		{
			view.stage.removeEventListener(Event.RESIZE, _resizeHandler);
		}
		
		private function _initUI(e:Event):void
		{
			view.stage.addEventListener(Event.RESIZE, _resizeHandler);

			_currentIssues = new HomeCurrentIssuesClp();
			_completeIssue = new HomeCompleteIssueClp();
			_lastArtists = new HomeLastArtistsUI(getOwner(), UIList.HOME_LAST_ARTISTS, new HomeLastArtistsClp());
			
			_header = new PreloaderWiper();
			_header.loadMedia(BeanFactory.getInstance().locate('HEADER_IMG_URL') as String);
				
			_welcomeText = new WelcomeTextUI(getOwner(), UIList.WELCOME_TEXT, new WelcomeTextClp());
            
			_mask = new Sprite();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(0, 0, view.stage.stageWidth, 402);
			_mask.graphics.endFill();
			_header.mask = _mask;
			
			with(view as MovieClip){
				addChild(_header);
				addChild(_welcomeText.view);
				addChild(_currentIssues);
				addChild(_completeIssue);	
			}
			
			_placeElements();
			
			EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(PrivateEventList.onLoadIssuesHomeUI, this));
			EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(PrivateEventList.onLoadProfilesHomeUI, this));
		}
		
		private function _placeElements():void
		{
			_lastArtists.view.y = _currentIssues.y = _completeIssue.y = 370;
			_currentIssues.x = 38;
			_completeIssue.x = 520;
			_lastArtists.view.x = 768;
			_welcomeText.view.y = 28;
            _welcomeText.view.x = 520;
		}
		
		public function initProfiles(lastProfiles:Array):void
		{
			_lastArtists.init(lastProfiles);
			(view as MovieClip).addChild(_lastArtists.view);
		}
		
		public function initIssues(o:Object):void
		{
			if(o.current_issues.length > 0)
			{
				_currentIssues.preview1.addChild((new HomeIssuePreviewUI(o.current_issues[0], getOwner(), UIList.HOME_ISSUE_PREVIEW_CURRENT_1, new HomeIssuePreviewClp())).view);
				if(o.current_issues.length > 1)
					_currentIssues.preview2.addChild((new HomeIssuePreviewUI(o.current_issues[1], getOwner(), UIList.HOME_ISSUE_PREVIEW_CURRENT_2, new HomeIssuePreviewClp())).view);	
			}
			_currentIssues.allIssues.addChild(new SmallButton(BeanFactory.getInstance().locate('ALL_ISSUES') as String, new PlusItem()));
			
			if(o.complete_issues.length > 0)
			{
				_completeIssue.preview1.addChild((new HomeIssuePreviewUI(o.complete_issues[0], getOwner(), UIList.HOME_ISSUE_PREVIEW_COMPLETE, new HomeIssuePreviewClp())).view);	
			}
			_completeIssue.allIssues.addChild(new SmallButton(BeanFactory.getInstance().locate('ALL_ISSUES') as String, new PlusItem()));
			
			_currentIssues.allIssues.addEventListener(MouseEvent.CLICK, _clickHandler);
			_completeIssue.allIssues.addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			EventBroadcaster.getInstance().broadcastEvent(new ObjectEvent(PrivateEventList.loadApplication, {
				url: BeanFactory.getInstance().locate('ISSUES_SWF') as String
			}));
		}
		
		private function _resizeHandler(e:Event):void
		{
			_mask.width = view.stage.stageWidth;
		}
	}
}