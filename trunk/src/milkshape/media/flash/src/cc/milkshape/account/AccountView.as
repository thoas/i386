package cc.milkshape.account
{
	import cc.milkshape.account.buttons.AccountMenuButton;
	import cc.milkshape.account.events.AccountMenuButtonEvent;
	
	import flash.events.Event;

	public class AccountView extends AccountClp
	{
		private const DEFAULT_MENU:String = 'creations';
		private var _listMenuItem:Object;
		private var _lastBtnClicked:AccountMenuButton;
		
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
		}
		
		private function _clickHandler(e:Event):void
		{
			_lastBtnClicked.reinitClick();
			_lastBtnClicked = e.currentTarget as AccountMenuButton;
			_lastBtnClicked.initClick();
			if(page.numChildren > 0)
				page.removeChildAt(0);
			page.addChild(_lastBtnClicked.params.view);
		}
	}
}