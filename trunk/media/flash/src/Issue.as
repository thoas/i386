package
{
	import grid.MemoryIndicator;
	import grid.GridController;
	import grid.GridModel;
	import grid.GridView;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(width='960', height='600', frameRate='30', backgroundColor='#141414')]
	
	public class Issue extends Sprite
	{
		public function Issue(issueId:int = 0)
		{
			stage.align = StageAlign.TOP_LEFT;
        	stage.scaleMode = StageScaleMode.NO_SCALE;
			var gridModel:GridModel = new GridModel(issueId);
			var gridController:GridController = new GridController(gridModel);
			var gridView:GridView = new GridView(gridModel, gridController, this.stage);
			addChild(gridView);
			addChild(new MemoryIndicator());
		}
	}
}