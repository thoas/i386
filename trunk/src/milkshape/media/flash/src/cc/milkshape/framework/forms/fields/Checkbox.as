package cc.milkshape.framework.forms.fields
{
	import flash.events.MouseEvent;
	
	public class Checkbox extends CheckboxClp
	{
		private var _status:Boolean;
		
		public function Checkbox()
		{
			_status = false;
			buttonMode = true;
			stop();
			bg.stop();
			
			addEventListener(MouseEvent.CLICK, _clickHandler);
		}
		
		public function get status():Boolean
		{
			return _status;
		}

		public function set status(v:Boolean):void
		{
			_status = v;
		}

		private function _clickHandler(e:MouseEvent):void
		{
			_status = !_status;
			if(_status)
				gotoAndStop('on');
			else
				gotoAndStop('off');
		}
	}
}