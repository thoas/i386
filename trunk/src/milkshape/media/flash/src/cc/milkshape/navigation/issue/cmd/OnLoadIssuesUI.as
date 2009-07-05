package cc.milkshape.navigation.issue.cmd
{
	import com.bourre.commands.AbstractCommand;
	import com.bourre.commands.Command;
	
	import flash.events.Event;

	public class OnLoadIssuesUI extends AbstractCommand implements Command
	{
		override public function execute(e:Event = null):void
		{
			getLogger().debug('onload: ' + this);
		}
	}
}