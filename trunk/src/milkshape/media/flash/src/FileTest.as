package {
    import cc.milkshape.grid.process.files.SquareProcessFile;
    
    import flash.display.Sprite;
    import flash.events.*;

    public class FileTest extends Sprite {

        public function FileTest() {
        	var file:SquareProcessFile = new SquareProcessFile("http://localhost:8000/media/issues/4x4/template/toto__x0_y0__4x4__2009-06-17--11-42-19.tiff");
        	file.downloadTpl();
        }
    }
}