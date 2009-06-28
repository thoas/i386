package cc.milkshape.account
{
	import cc.milkshape.account.buttons.AccountMenuButton;
	import cc.milkshape.account.events.AccountMenuButtonEvent;
	import cc.milkshape.framework.buttons.UnderlineButton;
	
	import com.gskinner.motion.GTween;
	import com.reintroducing.ui.AxisScroller;
	
	import fl.motion.easing.Sine;
	
	import flash.events.Event;

	public class AccountView extends AccountClp
	{
		private const DEFAULT_MENU:String = 'creations';
		private var _listMenuItem:Object;
		private var _lastBtnClicked:AccountMenuButton;
		private var _scrollItems:ScrollItemsClp;
		
		public function AccountView(menuArray:Array)
		{
			_listMenuItem = new Object();
			
			var deplaceY:int = 0;
			for each(var menuItem:Object in menuArray)
			{
				var accountMenuButton:AccountMenuButton = new AccountMenuButton(menuItem);
				accountMenuButton.addEventListener(AccountMenuButtonEvent.CLICKED, _clickHandler);
				accountMenuButton.y = deplaceY;
				deplaceY += accountMenuButton.height + 1;
				menu.addChild(accountMenuButton);
				
				_listMenuItem[menuItem.label] = accountMenuButton;
			}
			
			_lastBtnClicked = _listMenuItem[DEFAULT_MENU];
            _lastBtnClicked.initClick();
            
            addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_scrollItems = new ScrollItemsClp();
			_scrollerOff();
			_deleteAndLoad(null);
			
			var optionalObj:Object = {
				scrollType: "easing", 
				isTrackClickable: true, 
				continuousScroll: false,
				easeFunc: Sine.easeOut, 
				duration: .25,
				scaleScroller: true,
				autoHideControls: true
			};

			var scroller:AxisScroller = new AxisScroller(stage, page, _scrollItems.scroller, page.container, _scrollItems.track, page.over, "y", optionalObj);
		}
		
		private function _clickHandler(e:Event):void
		{
			_lastBtnClicked.reinitClick();
			_lastBtnClicked = e.currentTarget as AccountMenuButton;
			_lastBtnClicked.initClick();
			new GTween(
				page.over, 
				0.2, {
				height: 0 }, {
				ease:Sine.easeOut}
			);
			new GTween(
				page.bg, 
				0.2, {
				height: 0 }, {
				ease:Sine.easeOut, completeListener: _deleteAndLoad}
			);
		}
		
		private function _scrollerOn():void
		{
			page.scrollItems.addChild(_scrollItems);
		}
		
		private function _scrollerOff():void
		{
			if(page.scrollItems.contains(_scrollItems))
				page.scrollItems.removeChild(_scrollItems);
		}
		
		private function _deleteAndLoad(e:Event):void
		{
			if(page.container.numChildren > 0)
				page.container.removeChildAt(0);
			
			page.container.addChild(_lastBtnClicked.params.view);
			
			var futurHeight:int = 0;
			if(page.container.height > 334)
			{
				futurHeight = 334;
				_scrollerOn();
			}
			else
			{
				futurHeight = Math.round(page.container.height);
				_scrollerOff();
			}
			
			new GTween(
				page.over, 
				0.3, {
				height: futurHeight }, {
				ease:Sine.easeOut, delay: 0.15}
			);
			new GTween(
				page.bg, 
				0.3, {
				height: futurHeight }, {
				ease:Sine.easeOut}
			);
		}
	}
}