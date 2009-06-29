package cc.milkshape.user.forms
{
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.framework.forms.fields.Checkbox;
	import cc.milkshape.framework.forms.fields.Input;
	import cc.milkshape.manager.KeyboardManager;
	import cc.milkshape.preloader.events.PreloaderEvent;
	import cc.milkshape.user.LoginController;
	import cc.milkshape.user.events.LoginEvent;
	import cc.milkshape.utils.Constance;
	import cc.milkshape.utils.Label;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	public class LoginForm extends LoginClp implements Formable
	{
		private var _loginController:LoginController;
		private var _connectBtn:SmallButton;
		private var _checkboxRemember:Checkbox;
		private var _login:Input;
		private var _password:Input;
		private var _forgetIt:Label;
		private var _logout:LogoutBtnClp;
		private var _profil:Label;
		private var _notif:Label;
		private var _hello:Label;
		private var _registerStatut:Boolean;
		
		public function LoginForm(loginController:LoginController)
		{
			_loginController = loginController;
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			_loginController.addEventListener(LoginEvent.LOGGED, _logged);	
			_loginController.addEventListener(LoginEvent.LOGOUT, _disconnected);
			_loginController.addEventListener(LoginEvent.ERROR, _error);		
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_connectBtn = new SmallButton('LOGIN', new PlusItem());
			_forgetIt = new Label(new LabelStandard0758Clp(), 'forgot it ?', 0x8f8f8f);
			_checkboxRemember = new Checkbox();
			_login = new Input('username');
			_password = new Input('password', true);
			_logout = new LogoutBtnClp();
			_profil = new Label(new LabelStandard0765Clp(), 'PROFILE', Constance.COLOR_YELLOW);
			_notif = new Label(new LabelStandard0765Clp(), '', 0x8f8f8f);
			_hello = new Label(new LabelStandard0765Clp(), '', 0x8f8f8f);
			
			_logout.btn.stop();
			_registerStatut = false;
			register.buttonMode = true;			
			register.stop();
			register.addEventListener(MouseEvent.CLICK, _clickHandlerRegister);
			notif.addChild(_notif);
			connectBtn.addChild(_connectBtn);
			forgetIt.addChild(_forgetIt);
			checkboxRemember.addChild(_checkboxRemember);
			inputLogin.addChild(_login);
			inputPassword.addChild(_password);
			logout.addChild(_logout);
			profil.addChild(_profil);
			hello.addChild(_hello);
			errorArea.text = '';
			
			_password.label.tabIndex = 2;
			_login.label.tabIndex = 1;
			
			_login.label.addEventListener(FocusEvent.FOCUS_OUT, _handlerFocusOut);
			_password.label.addEventListener(FocusEvent.FOCUS_OUT, _handlerFocusOut);
			_login.label.addEventListener(FocusEvent.FOCUS_IN, _handlerFocusIn);
			_password.label.addEventListener(FocusEvent.FOCUS_IN, _handlerFocusIn);
			
			login.buttonMode = true;
			login.addEventListener(MouseEvent.CLICK, _formHandler);
			
			logout.buttonMode = true;
			logout.addEventListener(MouseEvent.CLICK, _logoutHandler);
			logout.addEventListener(MouseEvent.ROLL_OVER, _logoutOverHandler);
			logout.addEventListener(MouseEvent.ROLL_OUT, _logoutOutHandler);
			
			profil.buttonMode = true;
			profil.addEventListener(MouseEvent.CLICK, _profilHandler);
			
			_loginController.isAuthenticated();
		}
		
		private function _logoutOverHandler(e:MouseEvent):void
		{
			_logout.btn.play();
		}
		
		private function _logoutOutHandler(e:MouseEvent):void
		{
			_logout.btn.gotoAndStop('start');
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
		
		private function _logoutHandler(e:MouseEvent):void
		{
			_loginController.logout();
		}
		
		private function _formHandler(e:MouseEvent):void
		{
			stage.focus = _login.label;
			KeyboardManager.enabled = false;
			gotoAndPlay('form');
			_connectBtn.addEventListener(MouseEvent.CLICK, _loginHandler);
        }
        
        private function _handlerFocusOut(e:FocusEvent):void
        {
        	e.target.removeEventListener(KeyboardEvent.KEY_DOWN, _handlerKeyboard);
        }
        
        private function _handlerFocusIn(e:FocusEvent):void
        {
        	e.target.addEventListener(KeyboardEvent.KEY_DOWN, _handlerKeyboard);
        }
        
        private function _handlerKeyboard(e:KeyboardEvent):void
        {
        	if(e.keyCode == Keyboard.ENTER)
        		_loginHandler(null);        		
        }
        
        private function _logged(e:LoginEvent):void 
        {
        	gotoAndPlay('logged');
        	var user:Object = e.result;
        	_hello.text = 'Hello ' + user.username + '!';
        	_notif.text = 'x squares are waiting you';
        }
        
        private function _loginHandler(e:MouseEvent):void
        {
        	_loginController.login(_login.label.text, _password.label.text);
        }
        
        private function _disconnected(e:LoginEvent):void
        {
        	gotoAndStop('button');
        }
		
		public function values():Object
		{
			return {
				'login': _login.label.text,
				'password': _password.label.text
			};
		}
		
		public function reset():void
		{
			_login.blur();
			_password.blur();
		}
		
		private function _profilHandler(e:MouseEvent):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, {'url': 'account.swf', 'background': true}));
		}
		
		private function _error(e:LoginEvent):void
		{
			errorArea.text = '';
			for each(var error:String in e.result.errors)
				errorArea.text += error + "\n";
		}
	}
}