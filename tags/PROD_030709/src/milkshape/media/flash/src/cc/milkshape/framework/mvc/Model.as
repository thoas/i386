package cc.milkshape.framework.mvc
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Model extends EventDispatcher
	{
		public function Model(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}