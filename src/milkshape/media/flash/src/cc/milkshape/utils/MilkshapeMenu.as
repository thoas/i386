package cc.milkshape.utils
{
	import flash.events.Event;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.ContextMenuBuiltInItems;

	public class MilkshapeMenu
	{
		private var _cm:ContextMenu;

		public function MilkshapeMenu()
		{
			_cm = new ContextMenu();
			RemoveDefaultItems();
			AddCustomMenuItems();
		}

		private function RemoveDefaultItems():void
		{
			_cm.hideBuiltInItems();
			var defaultItems:ContextMenuBuiltInItems = _cm.builtInItems;
			defaultItems.print = true;
		}

		private function AddCustomMenuItems():void
		{
			var _cmItemCopyright:ContextMenuItem = new ContextMenuItem("© 2009 Milkshape");
			var _cmItemContact:ContextMenuItem = new ContextMenuItem("Contact us");
			var _cmItemShortcut1:ContextMenuItem = new ContextMenuItem("Raccourci", true);
			_cmItemContact.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, MailTo);
			
			_cm.customItems.push(_cmItemCopyright);
			_cm.customItems.push(_cmItemContact);
			_cm.customItems.push(_cmItemShortcut1);
		}

		private function MailTo(event:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("mailto:contact@milkshape.cc"));
		}
		
		public function get cm():ContextMenu { return _cm; }
	}
}
