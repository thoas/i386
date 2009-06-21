package cc.milkshape.grid.process.files
{
	import flash.net.URLRequest;
	public class SquareProcessFileDownload extends SquareProcessFile
	{
		public function SquareProcessFileDownload(URI:String=null)
		{
			super(URI);
		}
		
		public function downloadTpl(request:URLRequest = null, defaultFileName:String=null) : void
		{
			if(request == null)
				request = _request;
			download(_request, defaultFileName);
		}
	}
}