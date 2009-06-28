package cc.milkshape.register
{
	import cc.milkshape.register.forms.RegisterForm;
	import cc.milkshape.utils.TableLine;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Register extends Sprite
	{
		private var _registerForm:RegisterForm;
		
		public function Register()
		{
			//dispatchEvent(new Event('CLOSE_REGISTER'));
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _handlerRemovedFromStage);
		}
		
		private function _handlerRemovedFromStage(e:Event):void
		{
			stage.removeEventListener(Event.RESIZE, _handlerResize);
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			stage.addEventListener(Event.RESIZE, _handlerResize);
			_registerForm = new RegisterForm();

			_registerForm.bg2.addChild(new TableLine(stage.stageWidth*2, stage.stageHeight*2, 100, 100, 0x202020));
			
			addChild(_registerForm);
			_handlerResize(null);
		}
		
		private function _handlerResize(e:Event):void
		{
			_registerForm.bg.height = stage.stageHeight;
			_registerForm.bg3.height = stage.stageHeight;
			_registerForm.bg3.width = stage.stageWidth;
		}
	}
}