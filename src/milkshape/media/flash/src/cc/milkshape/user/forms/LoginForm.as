package cc.milkshape.user.forms
{
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.manager.KeyboardManager;
	import cc.milkshape.user.LoginController;
	import cc.milkshape.user.events.LoginEvent;
	import cc.milkshape.utils.Label;
	import cc.milkshape.utils.SmallButton;
	import cc.milkshape.utils.Constance;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	public class LoginForm extends LoginClp implements Formable
	{
		private var _loginController:LoginController;
		private var _connectBtn:SmallButton;
		private var _checkboxRemember:CheckboxClp;
		private var _inputLogin:InputClp;
		private var _inputPassword:InputClp;
		private var _forgetIt:Label;
		private var _logout:Label;
		private var _profil:Label;
		private var _notif:Label;
		private var _hello:Label;
		private var _registerStatut:Boolean;
		
		public function LoginForm(loginController:LoginController)
		{
			_loginController = loginController;
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			_loginController.addEventListener(LoginEvent.LOGGED, _logged);			
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_connectBtn = new SmallButton('LOGIN', new PlusItem());
			_forgetIt = new Label(new LabelStandard0758Clp(), 'forget it ?', 0x8f8f8f);
			_checkboxRemember = new Checkbox();
			_inputLogin = new Input('username');
			_inputPassword = new Input('password', true);
			_logout = new Label(new LabelStandard0765Clp(), 'LOGOUT', 0x8f8f8f);
			_profil = new Label(new LabelStandard0765Clp(), 'PROFIL', Constance.COLOR_YELLOW);
			_notif = new Label(new LabelStandard0765Clp(), 'You are', 0x8f8f8f);
			_hello = new Label(new LabelStandard0765Clp(), 'Hello Mec', 0x8f8f8f);
			
			_registerStatut = false;
			register.buttonMode = true;			
			register.stop();
			register.addEventListener(MouseEvent.CLICK, _clickHandlerRegister);
			notif.addChild(_notif);
			connectBtn.addChild(_connectBtn);
			forgetIt.addChild(_forgetIt);
			checkboxRemember.addChild(_checkboxRemember);
			inputLogin.addChild(_inputLogin);
			inputPassword.addChild(_inputPassword);
			logout.addChild(_logout);
			profil.addChild(_profil);
			hello.addChild(_hello);
			
			_inputLogin.label.tabIndex = 1;
			_inputPassword.label.tabIndex = 2;
			connectBtn.tabIndex = 3;
			
			login.buttonMode = true;
			login.addEventListener(MouseEvent.CLICK, _clickHandler);
		} 
		
		private function _clickHandlerRegister(e:MouseEvent):void
		{
			_registerStatut = !_registerStatut;
			if (!register.hasEventListener(Event.ENTER_FRAME))
				register.addEventListener(Event.ENTER_FRAME, _enterFrameRegister);
		}
		
		private function _enterFrameRegister(e:Event):void
		{
			if (_registerStatut) {
				register.nextFrame();
			} else {
				register.prevFrame();
			}
			if (register.currentLabel == 'start' || register.currentLabel == 'end')
			{
				
				register.removeEventListener(Event.ENTER_FRAME, _enterFrameRegister);
			}
		}
		
		private function _clickHandler(e:MouseEvent):void
		{
			stage.focus = _inputLogin.label;
			KeyboardManager.enabled = false;
			gotoAndPlay('form');
			_connectBtn.addEventListener(MouseEvent.CLICK, _login);
        }
        
        private function _logged(e:LoginEvent):void {
        	gotoAndPlay('logged');
        	var user:Object = e.user;
        	MonsterDebugger.trace(this, user);
        }
        
        private function _login(e:MouseEvent):void
        {
        	_loginController.login(_inputLogin.label.text, _inputPassword.label.text);
        }
		
		public function values():Object
		{
			return {
				'login': _inputLogin.label.text,
				'password': _inputPassword.label.text
			};
		}
		
	}
}