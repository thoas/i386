package
{
	import grid.GridController;
	import grid.GridModel;
	import grid.GridView;
	import flash.display.Sprite;
	
	[SWF(width='960', height='600', frameRate='30', backgroundColor='#ffffff')]
	
	public class Issue extends Sprite
	{
		public function Issue(issueId:int = 0)
		{
			var gridModel:GridModel = new GridModel(issueId);
			var gridController:GridController = new GridController(gridModel);
			var gridView:GridView = new GridView(gridModel, gridController, this.stage);
			addChild(gridView);
		}
	}
}