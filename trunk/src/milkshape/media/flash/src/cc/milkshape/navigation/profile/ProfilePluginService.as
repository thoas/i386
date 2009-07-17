package cc.milkshape.navigation.profile
{
    import cc.milkshape.framework.remoting.ServerAbstractCommand;
    import cc.milkshape.framework.remoting.ProxyService;

    import com.bourre.remoting.AbstractServiceProxy;
    import com.bourre.remoting.ServiceMethod;
    import com.bourre.remoting.ServiceResponder;

    import flash.net.URLRequest;
    public class ProfilePluginService extends AbstractServiceProxy
    {
        protected static const LAST_PROFILES:ServiceMethod = new ServiceMethod('profile.last_profiles'); 

        public function ProfilePluginService(sURL:URLRequest, sServiceName:String = null)
        {
            super(sURL, sServiceName);
        }

        public function lastProfiles(remoteCommand:ServerAbstractCommand):void
        {
            var sr:ServiceResponder = new ServiceResponder(remoteCommand.onResult, remoteCommand.onFault);
            ProxyService.getInstance().callServiceMethod(this, LAST_PROFILES, sr);
        } 
    }
}