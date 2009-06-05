package cc.milkshape.utils
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import cc.milkshape.preloader.events.PreloaderEvent;
	
	public class Menu extends Sprite
	{
		private var _format:TextFormat;
		private var _marginX:int;
		private var _deplaceX:int;
		private var _listMenuItem:Array;
		
		public function Menu(array:Array)
		{
			_marginX = 20;
			_deplaceX = -20;
			_listMenuItem = new Array();
			_format = new TextFormat();
            _format.font = "Verdana";
            _format.color = 0xFFFFFF;
            _format.size = 12;
            
            for each(var o:Object in array)
            {
            	var menuItem:MenuItemClip = new MenuItemClip();
            	
            	menuItem.buttonMode = true;
            	menuItem.label.text = o.label;
            	menuItem.slug = o.slug;
				menuItem.x = _deplaceX + _marginX;
				_deplaceX += menuItem.width + _marginX;
				
				menuItem.addEventListener(MouseEvent.CLICK, _clickOnItem);
            	_listMenuItem.push(addChild(menuItem));			
            }
			
		}
		
		private function _clickOnItem(e:MouseEvent):void
		{
			dispatchEvent(new PreloaderEvent(PreloaderEvent.INFO, e.currentTarget.slug));
		}
		
	}
}