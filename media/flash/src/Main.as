﻿package{	import cc.milkshape.preloader.PreloaderEvent;	import cc.milkshape.preloader.PreloaderKb;	import cc.milkshape.utils.Fullscreen;	import cc.milkshape.utils.Login;	import cc.milkshape.utils.Logo;	import cc.milkshape.utils.MemoryIndicator;	import cc.milkshape.utils.Menu;	import cc.milkshape.utils.MilkshapeMenu;	import cc.milkshape.utils.LoginForm;	import cc.milkshape.utils.SoundController;		import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;		import nl.demonsters.debugger.MonsterDebugger;			[SWF(width='960', height='600', frameRate='31', backgroundColor='#141414')]		public class Main extends Sprite	{		private var _menu:Menu;		private var _login:Login;		private var _logo:Logo;		private var _memoryIndicator:MemoryIndicator;		private var _fullscreen:Fullscreen;		private var _preloader:PreloaderKb;		private var _loginForm:LoginForm;		private var _soundController:SoundController;				public function Main()		{			var debugger:MonsterDebugger = new MonsterDebugger(this);			MonsterDebugger.trace(this, "Hello World!");						addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);		}				private function _handlerAddedToStage(e:Event):void		{			stage.align = StageAlign.TOP_LEFT;        	stage.scaleMode = StageScaleMode.NO_SCALE;        	stage.addEventListener(Event.RESIZE, _resize);        	        	var mct:MilkshapeMenu = new MilkshapeMenu();// Menu contextuel personnalisé			contextMenu = mct.cm;        				_menu = new Menu(new Array(				{label: 'Home', slug: 'home'},				{label: 'Issues', slug: 'issues'},				{label: 'Artists', slug: 'artists'},				{label: 'About', slug: 'about'},				{label: 'Contact', slug: 'contact'}			));			_menu.addEventListener(PreloaderEvent.INFO, _loadSwf);			_memoryIndicator = new MemoryIndicator();			_fullscreen = new Fullscreen();			_soundController = new SoundController();			_login = new Login();			_logo = new Logo();			_loginForm = new LoginForm();			_loginForm.x = 200;			try			{				_preloader = new PreloaderKb('issue.swf', String(50));			}			catch(e:Error)			{				trace(e.message);			}						addChild(_preloader);			addChild(_menu);			addChild(_login);			addChild(_logo);			addChild(_memoryIndicator);			addChild(_fullscreen);			addChild(_loginForm);			addChild(_soundController);						_resize();		}				private function _loadSwf(e:PreloaderEvent):void		{			_preloader.unloadMedia();			try			{				_preloader.loadMedia(e.msg + ".swf");			}			catch(e:Error)			{				trace(e.message);			}		}				private function _resize(e:Event = null):void		{			_fullscreen.x = stage.stageWidth - 70;			_soundController.x = _fullscreen.x - 30;			_memoryIndicator.x = stage.stageWidth - 60;			_memoryIndicator.y = stage.stageHeight - 20;						_menu.y = stage.stageHeight - 23;		}	}}