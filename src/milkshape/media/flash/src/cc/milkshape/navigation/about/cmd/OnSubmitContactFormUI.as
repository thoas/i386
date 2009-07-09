package cc.milkshape.navigation.about.cmd
{
	import cc.milkshape.framework.remoting.ProxyService;
	import cc.milkshape.framework.remoting.ServerAbstractCommand;
	import cc.milkshape.navigation.about.AboutPluginService;
	import cc.milkshape.navigation.about.view.ContactFormUI;
	import cc.milkshape.navigation.generic.PluginsServiceList;
	
	import com.bourre.events.ObjectEvent;
	import com.bourre.remoting.events.BasicResultEvent;
	
	import flash.events.Event;
	
	public class OnSubmitContactFormUI extends ServerAbstractCommand
	{
		override public function execute(e:Event = null):void
		{
			var contactFormUI:ContactFormUI = ((e as ObjectEvent).getTarget() as ContactFormUI);
			AboutPluginService(ProxyService.getInstance().locate(PluginsServiceList.ABOUT)).contact(this); 
		}
		
		override public function onResult(e:BasicResultEvent):void
		{
			//ContactFormUI(getView(UIList.CONTACT_FORM))
		}
	}
}