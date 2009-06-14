package cc.milkshape.user.forms
{
	import flash.events.MouseEvent;
	
	public class Checkbox extends CheckboxClp
	{
		private var _statut:Boolean;
		
		public function Checkbox()
		{
			_statut = false;
			buttonMode = true;
			stop();
			bg.stop();
			
			addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			_statut = !_statut;
			if(_statut)
				gotoAndStop('on');
			else
				gotoAndStop('off');
		}
		
		public function get statut():Boolean
		{
			return _statut;
		}

		public function set statut(v:Boolean):void
		{
			_statut = v;
		}
	}
}