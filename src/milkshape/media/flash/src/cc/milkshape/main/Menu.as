package cc.milkshape.main
{
	import cc.milkshape.main.buttons.*;
	import cc.milkshape.main.events.MenuButtonEvent;
	import cc.milkshape.preloader.events.PreloaderEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Menu extends Sprite
	{
		private const DEFAULT_MENU:String = 'home';
		private var _deplaceX:int;
		private var _listMenuItem:Object;
		private var _lastBtnClicked:MenuButton;
		
		public function Menu(array:Array)
		{
			_deplaceX = 0;
			_listMenuItem = new Object();
            
            for(var i:int = 0; i < array.length; i++)
            {
            	var menuButton:MenuButton = new MenuButton(array[i].label, array[i]);
				menuButton.x = _deplaceX;
				_deplaceX += menuButton.width + 20;            	
            	addChild(menuButton);
            	
            	menuButton.addEventListener(MenuButtonEvent.CLICKED, _clickHandler);
            	
            	_listMenuItem[array[i].label] = menuButton;
            	
            	if(i != array.length - 1)// si on est pas au dernier item, on affiche une separation
            	{
            		var menuSepar:MenuSeparClp = new MenuSeparClp();
            		menuSepar.x = _deplaceX;
            		_deplaceX += 21;
            		menuSepar.y = 3;
            		addChild(menuSepar);
            	}
            }
            
            _lastBtnClicked = _listMenuItem[DEFAULT_MENU];
            _lastBtnClicked.initClick();
		}
		
		public function getMenuButton(label:String):MenuButton
		{
			return _listMenuItem[label];
		}
		
		private function _clickHandler(e:Event):void
		{
			_lastBtnClicked.reinitClick();
			_lastBtnClicked = e.currentTarget as MenuButton;
			dispatchEvent(new PreloaderEvent(PreloaderEvent.LOAD, _lastBtnClicked.option));
		}
		
	}
}