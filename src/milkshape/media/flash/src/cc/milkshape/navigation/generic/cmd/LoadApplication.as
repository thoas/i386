package cc.milkshape.navigation.generic.cmd
{
    import cc.milkshape.framework.ApplicationFactory;
    import cc.milkshape.navigation.generic.ApplicationList;
    import cc.milkshape.preloader.events.PreloaderEvent;

    import com.bourre.commands.AbstractCommand;
    import com.bourre.commands.Command;
    import com.bourre.events.ObjectEvent;

    import flash.events.Event;	
    public class LoadApplication extends AbstractCommand implements Command
    {
        override public function execute(e:Event = null):void
        {
            (ApplicationFactory.getInstance().locate(ApplicationList.MAIN) as Main).loadSwf(new PreloaderEvent(PreloaderEvent.LOAD, (e as ObjectEvent).getTarget()));
        }
    }
}