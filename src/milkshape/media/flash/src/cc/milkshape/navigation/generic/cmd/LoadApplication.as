package cc.milkshape.navigation.generic.cmd
{
	import cc.milkshape.preloader.events.PreloaderEvent;
	
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;
	import com.bourre.events.ObjectEvent;
	
	import flash.events.Event;	

	public class LoadApplication extends AbstractCommand implements Command
	{
		override public function execute(e:Event = null):void
		{
			Main.getInstance().loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, (e as ObjectEvent).getTarget()));
		}
	}
}