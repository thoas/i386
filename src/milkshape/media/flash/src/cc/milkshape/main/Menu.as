package cc.milkshape.main
{
	import cc.milkshape.main.buttons.*;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Menu extends Sprite
	{
		private var _deplaceX:int;
		private var _listMenuItem:Array;
		private var _lastBtnClicked:MenuButton;
		
		public function Menu(array:Array)
		{
			_deplaceX = 0;
			_listMenuItem = new Array();
            
            for(var i:int = 0; i < array.length; i++)
            {
            	var menuButton:MenuButton = new MenuButton(array[i].label, array[i].slug);
				menuButton.x = _deplaceX;
				_deplaceX += menuButton.width + 20;            	
            	addChild(menuButton);
            	
            	menuButton.addEventListener('CLICKED', _clickHandler);
            	
            	_listMenuItem.push(menuButton);
            	
            	if(i != array.length - 1)// si on est pas au dernier item, on affiche une separation
            	{
            		var menuSepar:MenuSeparClp = new MenuSeparClp();
            		menuSepar.x = _deplaceX;
            		_deplaceX += 21;
            		menuSepar.y = 3;
            		addChild(menuSepar);
            	}
            }
            
            _listMenuItem[0].initClick();
            _lastBtnClicked = _listMenuItem[0];
		}
		
		private function _clickHandler(e:Event):void
		{
			_lastBtnClicked.reinitClick();
			_lastBtnClicked = e.currentTarget as MenuButton;
		}
		
	}
}