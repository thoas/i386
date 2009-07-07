package cc.milkshape.navigation.issue.view
{
	import cc.milkshape.framework.buttons.ArrowButton;
	import cc.milkshape.navigation.generic.PrivateEventList;
	import cc.milkshape.navigation.generic.UIList;
	
	import com.bourre.events.BasicEvent;
	import com.bourre.events.EventBroadcaster;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Cubic;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class IssuesUI extends AbstractView
	{
		private var _nextBtn:ArrowButton;
		private var _prevBtn:ArrowButton;
		private var _countIssues:int;
		private var _nbCompleteIssues:int;
		public function IssuesUI(owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
			if(mc)
			{
				mc.addEventListener(Event.ADDED_TO_STAGE, _initUI);
			}
		}
		
		private function _initUI(e:Event):void
		{
			EventBroadcaster.getInstance().broadcastEvent(new BasicEvent(PrivateEventList.onLoadIssuesUI, this));
		}
		
		public function init(o:Object):void
		{
			createNav();
			var issuePreview:IssuePreviewUI;
			var i:int;
			
			for(i = 0; i < o.current_issues.length; i++)
			{ 
				issuePreview = new IssuePreviewUI(o.current_issues[i], getOwner(), UIList.ISSUE_PREVIEW_CURRENT + '_' + i, new IssuePreviewClp());
				issuePreview.view.x = 1000;
				new GTween(issuePreview.view, 0.5, { x: i * 239 }, { ease:Cubic.easeInOut, delay: i * 0.04 });
				(view as IssuesClp).currentContainer.addChild(issuePreview.view);
			}
			
			_nbCompleteIssues = o.complete_issues.length;
			for(i = 0; i < _nbCompleteIssues; i++)
			{
				issuePreview = new IssuePreviewUI(o.complete_issues[i], getOwner(), UIList.ISSUE_PREVIEW_COMPLETE + '_' + i, new IssuePreviewClp());
				if(i < 4)
				{
					issuePreview.view.x = 1000;
					new GTween(issuePreview.view, 0.5, { x: i * 239 }, { ease:Cubic.easeInOut, delay: i * 0.2 + 0.5 });
				}
				else
				{
					issuePreview.view.x = i * 239;
				}
				(view as IssuesClp).completeContainer.addChild(issuePreview.view);
			}
			
			if(_nbCompleteIssues > 4)
				(view as IssuesClp).next.addChild(_nextBtn);
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
				(view as IssuesClp).prev.removeChild(_prevBtn);
				(view as IssuesClp).next.addChild(_nextBtn);
			}
			else if(_countIssues >= _nbCompleteIssues - 4)
			{
				(view as IssuesClp).next.removeChild(_nextBtn);
				(view as IssuesClp).prev.addChild(_prevBtn);
			}
			else
			{
				(view as IssuesClp).prev.addChild(_prevBtn);
			}
		}
		
		private function _nextIssue(e:MouseEvent):void
		{
			_navListnerDisabled();
			new GTween((view as IssuesClp).completeContainer, 0.5, { x: (view as IssuesClp).completeContainer.x - 239 }, { ease:Cubic.easeInOut, completeListener:_navListnerEnabled });	
			_checkNav(1);
		}
		
		private function _prevIssue(e:MouseEvent):void
		{
			_navListnerDisabled();
			new GTween((view as IssuesClp).completeContainer, 0.5, { x: (view as IssuesClp).completeContainer.x + 239 }, { ease:Cubic.easeInOut, completeListener:_navListnerEnabled });
			_checkNav(-1);
		}
	}
}