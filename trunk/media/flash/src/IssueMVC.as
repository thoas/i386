package
{
	import mvc.GridController;
	import mvc.GridModel;
	import mvc.GridView;
	import flash.display.Sprite;
	
	[SWF(width='960', height='600', frameRate='30', backgroundColor='#ffffff')]
	
	public class IssueMVC extends Sprite
	{
		public function IssueMVC(issueId:int = 0)
		{
			var gridModel:GridModel = new GridModel(issueId);
			var gridController:GridController = new GridController(gridModel);
			var gridView:GridView = new GridView(gridModel, gridController, this.stage);
			addChild(gridView);
		}
	}
}