package
{
	import flash.display.MovieClip;
	import grid.Grid;
	
	[SWF(width='960', height='600', frameRate='30', backgroundColor='#ffffff')]
	
	public class Issue extends MovieClip
	{
		private var _grid:Grid;
		private var _maxParticipation:int;
		private var _title:String;
		private var _textPresentation:String;
		
		public function Issue(nbColumn:int = 10, nbLine:int = 5)
		{
			var sq1:grid.square.SquareFull = new grid.square.SquareFull();
			sq1.pos_x = 0;
			sq1.pos_y = 0;
			sq1.background_image_path = 'thoas/209320372037_0_0';
			sq1.status = 1;
			
			var sq2:grid.square.SquareFull = new grid.square.SquareFull();
			sq2.pos_x = 1;
			sq2.pos_y = 0;
			sq2.background_image_path = 'jeanjack/209320372038_1_0';
			sq2.status = 1;
			
			var sq3:grid.square.SquareFull = new grid.square.SquareFull();
			sq3.pos_x = 0;
			sq3.pos_y = 1;
			sq3.background_image_path = null;
			sq3.status = 0;
			
			var sq4:grid.square.SquareFull = new grid.square.SquareFull();
			sq4.pos_x = 1;
			sq4.pos_y = 1;
			sq4.background_image_path = null;
			sq4.status = 0;
			
			var sq6:grid.square.SquareBooked = new grid.square.SquareBooked();
			sq6.pos_x = 1;
			sq6.pos_y = 2;
			sq6.background_image_path = null;
			sq6.status = 0;
			
			var chapter:Object = new Object();
			chapter.title = 'Bac à sable';
			chapter.text_presentation = 'Bac à sable desc';
			chapter.nb_square_x = 0;
			chapter.nb_square_y = 0;
			chapter.max_participation = 0;
			chapter.squares = new Array(sq1, sq2, sq3, sq4, sq5, sq6);
			chapter.min_x = -10;
			chapter.max_x = 5;
			chapter.min_y = -3;
			chapter.max_y = 8;
			
			_grid = new Grid(chapter.squares);
			addChild(_grid);
		}	
	}
}