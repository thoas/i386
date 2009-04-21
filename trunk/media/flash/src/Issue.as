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
			var sq1:Objet = new Object();
			sq1.pos_x = 0;
			sq1.pos_y = 0;
			sq1.background_image_path = 'thoas/209320372037_0_0';
			sq1.status = 1;
			
			var sq2:Objet = new Object();
			sq2.pos_x = 1;
			sq2.pos_y = 0;
			sq2.background_image_path = 'jeanjack/209320372038_1_0';
			sq2.status = 1;
			
			var sq3:Objet = new Object();
			sq3.pos_x = 1;
			sq3.pos_y = -1;
			sq3.background_image_path = null;
			sq3.status = 0;
			
			var sq4:Objet = new Object();
			sq4.pos_x = 1;
			sq4.pos_y = 1;
			sq4.background_image_path = null;
			sq4.status = 0;
			
			var sqo1:Objet = new Object();
			sqo1.pos_x = -1;
			sqo1.pos_y = -1;
			
			var sqo2:Objet = new Object();
			sqo2.pos_x = -1;
			sqo2.pos_y = 0;
			
			var sqo3:Objet = new Object();
			sqo3.pos_x = -1;
			sqo3.pos_y = 1;
			
			var chapter:Object = new Object();
			chapter.title = 'Bac à sable';
			chapter.text_presentation = 'Bac à sable desc';
			chapter.nb_square_x = 5;
			chapter.nb_square_y = 5;
			chapter.max_participation = 1;
			chapter.squares = new Array(sq1, sq2, sq3, sq4);
			chapter.squares_open = new Array(sqo1, sqo2, sqo3);
			/*chapter.min_x = 2;
			chapter.max_x = ;
			chapter.min_y = -3;
			chapter.max_y = 8;
			*/
			_grid = new Grid(chapter.squares, chapter.squares_open);
			addChild(_grid);
		}	
	}
}