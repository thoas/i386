package cc.milkshape.issue
{
	import cc.milkshape.framework.buttons.ArrowButton;
	import cc.milkshape.issue.events.IssuesEvent;
	
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Cubic;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class IssuesView extends MovieClip
	{
		private var _issueController:IssueController;
		private var _issueClp:IssuesClp;
		private var _nextBtn:ArrowButton;
		private var _prevBtn:ArrowButton;
		private var _countIssues:int;
		private var _nbCompleteIssues:int;
		
		public function IssuesView(issueController:IssueController)
		{
			_issueController = issueController;
			_issueController.addEventListener(IssuesEvent.LAST_ISSUES_LOADED, _loadIssues);
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_issueController.lastIssues()
		}
		
		private function _loadIssues(e:IssuesEvent):void
		{
			var o:Object = e.lastIssues;
			_issueClp = new IssuesClp();
			addChild(_issueClp);
			createNav();
			
			var issuePreview:IssuePreview;
			var i:int;
			
			for(i = 0; i < o.current_issues.length; i++)
			{ 
				issuePreview = new IssuePreview(o.current_issues[i]);
				issuePreview.x = 1000;
				new GTween(issuePreview, 0.5, { x: i * 239 }, { ease:Cubic.easeInOut, delay: i * 0.04 });
				_issueClp.currentContainer.addChild(issuePreview);
			}
			
			_nbCompleteIssues = o.complete_issues.length;
			for(i = 0; i < _nbCompleteIssues; i++)
			{
				issuePreview = new IssuePreview(o.complete_issues[i]);
				if(i < 4)
				{
					issuePreview.x = 1000;
					new GTween(issuePreview, 0.5, { x: i * 239 }, { ease:Cubic.easeInOut, delay: i * 0.2 + 0.5 });
				}
				else
				{
					issuePreview.x = i * 239;
				}
				_issueClp.completeContainer.addChild(issuePreview);
			}
			
			if(_nbCompleteIssues > 4)
				_issueClp.next.addChild(_nextBtn);
		}
		
		private function _inversePosition(mc:DisplayObject):void
		{
			mc.rotation = 180;
			mc.x += mc.width;
			mc.y += mc.height;
		}
		
		private function createNav():void
		{
			_nextBtn = new ArrowButton();
		 	_prevBtn = new ArrowButton();
			
			_inversePosition(_prevBtn);
			
			_navListnerEnabled();
		}
		
		private function _navListnerEnabled(e:Event = null):void
		{
			_nextBtn.addEventListener(MouseEvent.CLICK, _nextIssue);
			_prevBtn.addEventListener(MouseEvent.CLICK, _prevIssue);
		}
		
		private function _navListnerDisabled(e:Event = null):void
		{
			_nextBtn.removeEventListener(MouseEvent.CLICK, _nextIssue);
			_prevBtn.removeEventListener(MouseEvent.CLICK, _prevIssue);
		}
		
		private function _checkNav(op:int):void
		{
			_countIssues += op;
			
			if(_countIssues < 1)
			{
				_issueClp.prev.removeChild(_prevBtn);
				_issueClp.next.addChild(_nextBtn);
			}
			else if(_countIssues >= _nbCompleteIssues - 4)
			{
				_issueClp.next.removeChild(_nextBtn);
				_issueClp.prev.addChild(_prevBtn);
			}
			else
			{
				_issueClp.prev.addChild(_prevBtn);
			}
		}
		
		private function _nextIssue(e:MouseEvent):void
		{
			_navListnerDisabled();
			new GTween(_issueClp.completeContainer, 0.5, { x: _issueClp.completeContainer.x - 239 }, { ease:Cubic.easeInOut, completeListener:_navListnerEnabled });	
			_checkNav(1);
		}
		
		private function _prevIssue(e:MouseEvent):void
		{
			_navListnerDisabled();
			new GTween(_issueClp.completeContainer, 0.5, { x: _issueClp.completeContainer.x + 239 }, { ease:Cubic.easeInOut, completeListener:_navListnerEnabled });
			_checkNav(-1);
		}
	}
	
}