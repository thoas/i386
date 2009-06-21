package {
    import cc.milkshape.grid.process.files.SquareProcessFileDownload;
    
    import flash.display.Sprite;
    import flash.events.*;

    public class FileTest extends Sprite {

        public function FileTest() {
        	var file:SquareProcessFileDownload = new SquareProcessFileDownload("http://localhost:8000/media/issues/5x5/template/toto__x1_y1__5x5__2009-06-21--14-44-08.tiff");
        	file.downloadTpl();
        }
    }
}