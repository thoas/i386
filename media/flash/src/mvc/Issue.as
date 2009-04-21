package mvc
{
	import flash.display.Sprite;
	
	public class Issue extends Sprite
	{
		public function Issue(issueId:int)
		{
			var gridModel:GridModel = new GridModel(issueId);
			var gridController:GridController = new GridController(gridModel);
			var gridView:GridView = new GridView(gridModel, gridController, this.stage);
			addChild(gridView);
		}
	}
}