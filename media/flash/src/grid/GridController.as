package grid
{
	import flash.events.Event;
	
	public class GridController
	{
		private var _gridModel:GridModel;
		public function GridController(gridModel:GridModel)
		{
			_gridModel = gridModel;
		}
		
		public function getData(event:Event = null):Boolean
		{
			var issueId:int = _gridModel.issueId;
			
			// On envoit une requête en POST avec issue_id
			// On reçoit des beaux modèles hots.
			var sq1:Object = new Object();
			sq1.pos_x = 0;
			sq1.pos_y = 0;
			sq1.background_image_path = 'jeanjack/209320372038';
			sq1.status = 1;
			
			var sq2:Object = new Object();
			sq2.pos_x = 1;
			sq2.pos_y = 0;
			sq2.background_image_path = 'jeanjack/209320372038';
			sq2.status = 1;
			
			var sq3:Object = new Object();
			sq3.pos_x = 1;
			sq3.pos_y = -1;
			sq3.background_image_path = null;
			sq3.status = 0;
			
			var sq4:Object = new Object();
			sq4.pos_x = 1;
			sq4.pos_y = 1;
			sq4.background_image_path = null;
			sq4.status = 0;
			
			var sqo1:Object = new Object();
			sqo1.pos_x = -1;
			sqo1.pos_y = -1;
			
			var sqo2:Object = new Object();
			sqo2.pos_x = -1;
			sqo2.pos_y = 0;
			
			var sqo3:Object = new Object();
			sqo3.pos_x = -1;
			sqo3.pos_y = 1;
			
			var issue:Object = new Object();
			issue.title = 'Bac à sable';
			issue.text_presentation = 'Bac à sable desc';
			issue.nb_square_x = 0;
			issue.nb_square_y = 0;
			issue.show_disable_square = 0;
			issue.max_participation = 1;
			issue.squares = new Array(sq1, sq2, sq3, sq4);
			issue.squares_open = new Array(sqo1, sqo2, sqo3);
			issue.min_x = -1;
			issue.max_x = 1;
			issue.min_y = -1;
			issue.max_y = 1;
			
			_gridModel.init(issue.squares, issue.squares_open, issue.min_x, issue.min_y, issue.max_x, issue.max_y, issue.nb_square_x, issue.nb_square_y, issue.show_disable_square);
			
			return true;
		}
	}
}