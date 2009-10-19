﻿package{	import cc.milkshape.framework.Application;	import cc.milkshape.framework.events.ApplicationEvent;	import cc.milkshape.main.*;	import cc.milkshape.navigation.generic.ApplicationList;	import cc.milkshape.preloader.PreloaderKb;	import cc.milkshape.preloader.events.PreloaderEvent;	import cc.milkshape.register.Register;	import cc.milkshape.user.Login;	import cc.milkshape.utils.MilkshapeMenu;	import cc.milkshape.utils.TableLine;		import com.bourre.ioc.bean.BeanFactory;		import flash.display.LoaderInfo;	import flash.display.Shape;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.ColorTransform;

	[SWF(width='1430', height='680', frameRate='31', backgroundColor='#191919')]		public class Main extends Application	{		private const DEFAULT_CONTAINER_POSX:int = 20;		private const DEFAULT_CONTAINER_POSY:int = 100;		private const BAR_BG_COLOR:int = 0x0a0a0a;		private var _parameters:Object;		private var _equalizer:Equalizer;		private var _menu:Menu;		private var _subMenu:SubMenu;		private var _login:Login;		private var _logo:Logo;		private var _fullscreen:Fullscreen;		private var _pageContainer:PreloaderKb;		private var _bottomBar:Shape;		private var _topBar:Shape;		private var _background:TableLine;		private var _register:Register;				public function Main():void		{			var parameters:Object = LoaderInfo(this.root.loaderInfo).parameters as Object;			for(var key:String in parameters)			{				BeanFactory.getInstance().register(key, parameters[key]);			}			super(ApplicationList.MAIN, this);		}				override public function applicationLoadedHandler(e:ApplicationEvent):void		{			super.applicationLoadedHandler(e);			var mct:MilkshapeMenu = new MilkshapeMenu();			contextMenu = mct.cm;						stage.align = StageAlign.TOP_LEFT;        	stage.scaleMode = StageScaleMode.NO_SCALE;        	stage.addEventListener(Event.RESIZE, _resize);        	        				_menu = new Menu(new Array(				{label: 'home', slug: 'home', url: BeanFactory.getInstance().locate('HOME_SWF'), posX:0, posY:60},				{label: 'about', slug: 'about', url: BeanFactory.getInstance().locate('ABOUT_SWF')},				{label: 'issues', slug: 'issues', url: BeanFactory.getInstance().locate('ISSUES_SWF'), posX:0},				{label: 'artists', slug: 'artists', url: BeanFactory.getInstance().locate('ARTISTS_SWF')},				{label: 'contact', slug: 'contact', url: BeanFactory.getInstance().locate('CONTACT_SWF')}			));			_menu.addEventListener(PreloaderEvent.LOAD, loadSwf);						_subMenu = new SubMenu();			_subMenu.addEventListener(PreloaderEvent.LOAD, loadSwf);						_fullscreen = new Fullscreen();						_equalizer = new Equalizer();						_login = new Login();						_logo = new Logo();			_logo.addEventListener(MouseEvent.CLICK, _showRegister);						_bottomBar = new Shape();			_bottomBar.graphics.beginFill(BAR_BG_COLOR);			_bottomBar.graphics.drawRect(0, 0, stage.stageWidth, 33);			_bottomBar.graphics.endFill();						_topBar = new Shape();			_topBar.graphics.beginFill(BAR_BG_COLOR);			_topBar.graphics.drawRect(0, 0, stage.stageWidth, 60);			_topBar.graphics.endFill();						var errorArea:ErrorArea = ErrorArea.getInstance();						_pageContainer = new PreloaderKb();						_background = new TableLine(stage.stageWidth*2, stage.stageHeight*2, 100, 100, 0x202020);            var mainColorTransform:ColorTransform = new ColorTransform();			mainColorTransform.color = 0xffdd00;			_logo.transform.colorTransform = mainColorTransform;			mainColorTransform.color = 0x999999;			_fullscreen.transform.colorTransform = mainColorTransform;			_equalizer.transform.colorTransform = mainColorTransform;			addChild(_pageContainer);			addChild(_bottomBar);			addChild(_topBar);			addChild(_menu);			addChild(_subMenu);			addChild(_login);			addChild(_logo);			addChild(_fullscreen);			addChild(_equalizer);			addChild(errorArea);						_itemsDisposition();						loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, _menu.getMenuButton('home').option));		}				private function _showRegister(e:Event):void		{			_register = new Register();			_register.addEventListener('CLOSE_REGISTER', _closeRegister);			addChild(_register);			removeChild(_login);		}				private function _closeRegister(e:Event):void		{			_register.removeEventListener('CLOSE_REGISTER', _closeRegister);			if(contains(_register))			{				removeChild(_register);				addChild(_login);			}		}				public function loadSwf(e:PreloaderEvent):void		{			if((e.option.background != null) ? e.option.background : true)				addChildAt(_background, 0);			else if(contains(_background))				removeChild(_background);							_pageContainer.x = (e.option.posX != null) ? e.option.posX : DEFAULT_CONTAINER_POSX;			_pageContainer.y = (e.option.posY != null) ? e.option.posY : DEFAULT_CONTAINER_POSY;			try {				_pageContainer.unloadMedia();			} catch(e:Error) {				trace(e.message);			}						try {				_pageContainer.params = e.option.params;				_pageContainer.loadMedia(BeanFactory.getInstance().locate('FLASH_URL') + "/" + e.option.url);			} catch(e:Error){				trace(e.message);			}		}				private function _itemsDisposition():void		{			ErrorArea.getInstance().x = 610;			ErrorArea.getInstance().y = 24;			_pageContainer.y = 60;			_background.x = -50;			_menu.x = 37;			_logo.x = 37;			_logo.y = 12;			_login.x = 275;			_login.y = 24;			_fullscreen.y = 12;			_equalizer.y = _fullscreen.y + 20;			_resize();		}				private function _resize(e:Event = null):void		{			_topBar.width = stage.stageWidth;						_bottomBar.y = stage.stageHeight - 33;			_bottomBar.width = stage.stageWidth;							_fullscreen.x = stage.stageWidth - 27;			_equalizer.x = _fullscreen.x;			_menu.y = stage.stageHeight - 21;						_subMenu.y = stage.stageHeight - 23;			_subMenu.x = stage.stageWidth - 70;		}	}}