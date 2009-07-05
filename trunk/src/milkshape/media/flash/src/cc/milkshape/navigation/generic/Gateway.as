package cc.milkshape.navigation.generic
{
	import com.bourre.remoting.AbstractServiceProxy;
	
	import flash.net.URLRequest;
	
	public class Gateway extends AbstractServiceProxy
	{
		public function Gateway(sURL:URLRequest, sServiceName:String=null)
		{
			super(sURL, sServiceName);
		}
	}
}