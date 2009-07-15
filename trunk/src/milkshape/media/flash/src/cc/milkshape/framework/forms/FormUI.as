package cc.milkshape.framework.forms
{
	import cc.milkshape.framework.forms.widgets.WidgetForm;
	import cc.milkshape.framework.forms.widgets.WidgetFormSchema;
	
	import com.bourre.events.EventBroadcaster;
	import com.bourre.events.ObjectEvent;
	import com.bourre.plugin.Plugin;
	import com.bourre.view.AbstractView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class FormUI extends AbstractView
	{
		protected var _widgetSchema:WidgetFormSchema;
		public function FormUI(owner:Plugin=null, name:String=null, mc:DisplayObject=null)
		{
			super(owner, name, mc);
			resetFormFields();
			setup();
			configure();
		}
		
		public function setup():void
		{
			
		}
		
		public function configure():void
		{
			
		}
		
		public function setWidgets(widgets:Object):void
		{
			setWidgetSchema(widgets, view);
		}
		
		public function setWidgetSchema(widgets:Object, view:DisplayObject):void
		{
			_widgetSchema = new WidgetFormSchema(widgets, view);
		}
		
		public function getWidgetSchema():WidgetFormSchema
		{
			return _widgetSchema;
		}
		
		public function setWidget(key:String, widget:WidgetForm):void
		{
			_widgetSchema[key] = widget;
		}
		
		public function setSubmit(widget:WidgetForm, commandName:String):void
		{
			(widget.view as MovieClip).addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
				{
					onSubmit(e.clone(), commandName);
				}
			);
		}
		
		public function onSubmit(e:Event, commandName:String):void
		{
			EventBroadcaster.getInstance().broadcastEvent(new ObjectEvent(commandName, this));
		}
		
		public function getValue(key:String):String
		{
			return (getWidget(key) as Object).text;
		}
		
		public function getWidget(key:String):WidgetForm
		{
			if(_widgetSchema.containsKey(key))
				return _widgetSchema.get(key);
			return null;
		}
		
		public function resetFormFields():void
		{
			_widgetSchema = new WidgetFormSchema();
		}
	}
}