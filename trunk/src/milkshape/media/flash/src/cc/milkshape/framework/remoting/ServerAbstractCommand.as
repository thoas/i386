package cc.milkshape.framework.remoting
{
    import com.bourre.commands.AbstractCommand;
    import com.bourre.remoting.events.BasicFaultEvent;
    import com.bourre.remoting.events.BasicResultEvent;
    import com.bourre.remoting.interfaces.ServiceProxyListener;
    public class ServerAbstractCommand extends AbstractCommand implements ServiceProxyListener
    {
        public function ServerAbstractCommand()
        {
            super();
        }

        public function onResult(e:BasicResultEvent):void
        {
        }

        public function onFault(e:BasicFaultEvent):void
        {
        }
    }
}