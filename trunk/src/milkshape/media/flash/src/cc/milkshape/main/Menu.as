package cc.milkshape.main
{
	import cc.milkshape.preloader.events.PreloaderEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Menu extends Sprite
	{
		private var _deplaceX:int;
		private var _listMenuItem:Array;
		
		public function Menu(array:Array)
		{
			_deplaceX = 0;
			_listMenuItem = new Array();
            
            for(var i:int = 0; i < array.length; i++)
            {
            	var menuItem:MenuItemClp = new MenuItemClp();
            	
            	menuItem.buttonMode = true;
            	menuItem.txtClp.txt.text = array[i].label;
            	menuItem.slug = array[i].slug;
				menuItem.x = _deplaceX;
				_deplaceX += menuItem.width;
				
				menuItem.addEventListener(MouseEvent.MOUSE_OVER, _overHandler);
				menuItem.addEventListener(MouseEvent.MOUSE_OUT, _outHandler);
				menuItem.addEventListener(MouseEvent.CLICK, _clickOnItem);
            	_listMenuItem.push(addChild(menuItem));
            	
            	if(i != array.length - 1)// si on est pas au dernier item, on affiche une separation
            	{
            		var menuSepar:MenuSeparClp = new MenuSeparClp();
            		menuSepar.x = _deplaceX;
            		menuSepar.y = 4;
            		addChild(menuSepar);
            	}
            }
			
		}
		
		private function _overHandler(e:MouseEvent):void
		{
			var clip:MenuItemClp = e.currentTarget as MenuItemClp;
			clip.gotoAndPlay('over');
		}
		
		private function _outHandler(e:MouseEvent):void
		{
			var clip:MenuItemClp = e.currentTarget as MenuItemClp;
			clip.gotoAndPlay('out');
		}
		
		private function _clickOnItem(e:MouseEvent):void
		{
			dispatchEvent(new PreloaderEvent(PreloaderEvent.INFO, e.currentTarget.slug));
		}
		
	}
}