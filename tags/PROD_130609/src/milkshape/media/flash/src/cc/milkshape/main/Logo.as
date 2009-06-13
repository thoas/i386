package cc.milkshape.main
{
	import flash.events.MouseEvent;

	public class Logo extends LogoClp
	{
		public function Logo()
		{
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, _handlerClick);
		}
		
		private function _handlerClick(e:MouseEvent):void
		{
			trace('go to home');
		}
		
	}
}