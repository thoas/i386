package cc.milkshape.user.forms
{
	import cc.milkshape.framework.buttons.SmallButton;
	import cc.milkshape.framework.forms.Formable;
	import cc.milkshape.framework.forms.fields.Checkbox;
	import cc.milkshape.framework.forms.fields.Input;
	import cc.milkshape.manager.KeyboardManager;
	import cc.milkshape.user.LoginController;
	import cc.milkshape.user.events.LoginEvent;
	import cc.milkshape.utils.Constance;
	import cc.milkshape.utils.Label;
	import cc.milkshape.preloader.events.PreloaderEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LoginForm extends LoginClp implements Formable
	{
		private var _loginController:LoginController;
		private var _connectBtn:SmallButton;
		private var _checkboxRemember:Checkbox;
		private var _login:Input;
		private var _password:Input;
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
			_loginController.addEventListener(LoginEvent.LOGOUT, _disconnected);		
		}
		
		private function _handlerAddedToStage(e:Event):void
		{
			_connectBtn = new SmallButton('LOGIN', new PlusItem());
			_forgetIt = new Label(new LabelStandard0758Clp(), 'forget it ?', 0x8f8f8f);
			_checkboxRemember = new Checkbox();
			_login = new Input('username');
			_password = new Input('password', true);
			_logout = new Label(new LabelStandard0765Clp(), 'LOGOUT', 0x8f8f8f);
			_profil = new Label(new LabelStandard0765Clp(), 'PROFIL', Constance.COLOR_YELLOW);
			_notif = new Label(new LabelStandard0765Clp(), 'You are', 0x8f8f8f);
			_hello = new Label(new LabelStandard0765Clp(), '', 0x8f8f8f);
			
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
			
			_login.label.tabIndex = 1;
			_password.label.tabIndex = 2;
			connectBtn.tabIndex = 3;
			
			login.buttonMode = true;
			login.addEventListener(MouseEvent.CLICK, _formHandler);
			
			logout.buttonMode = true;
			logout.addEventListener(MouseEvent.CLICK, _logoutHandler);
			
			profil.buttonMode = true;
			profil.addEventListener(MouseEvent.CLICK, _profilHandler);
			
			_loginController.isAuthenticated();
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
        
        private function _logged(e:LoginEvent):void 
        {
        	gotoAndPlay('logged');
        	var user:Object = e.user;
        	_hello.text = 'Hello ' + user.username + '!';
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
	}
}