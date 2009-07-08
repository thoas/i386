package cc.milkshape.navigation.generic.view
{
	import cc.milkshape.navigation.generic.PrivateEventList;
	
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.ObjectEvent;
	import com.bourre.ioc.bean.BeanFactory;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class PreviewUI extends AbstractView
	{
		protected var _issue:Object;
		public function PreviewUI(owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
			with(view as MovieClip)
			{
				addEventListener(MouseEvent.ROLL_OVER, _overHandler);
				addEventListener(MouseEvent.ROLL_OUT, _outHandler);
				addEventListener(MouseEvent.CLICK, _clickHandler);
			}
		}
		
		protected function _clickHandler(e:MouseEvent):void
		{
			EventBroadcaster.getInstance().broadcastEvent(new ObjectEvent(PrivateEventList.onClickIssuePreviewUI, {
				url: BeanFactory.getInstance().locate('ISSUE_SWF') as String, 
				background: false,
				posX: BeanFactory.getInstance().locate('ISSUE_POSX') as String, 
				posY: BeanFactory.getInstance().locate('ISSUE_POSY') as String,  
				params: {slug: _issue.slug}
			}));
		}
		
		protected function _overHandler(e:MouseEvent):void
		{
		}
		
		protected function _outHandler(e:MouseEvent):void
		{
		}
	}
}