package 
{
	// Copyright (c) 2007-2009 The PyAMF Project.
	// See LICENSE for details.

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.net.NetConnection;
	import flash.net.Responder;

	public class echoGateway extends MovieClip 
	{		
		// Gateway connection object
		private var _gateway:NetConnection;

		public function echoGateway() 
		{
			// Setup connection
			_gateway = new NetConnection();

			// Connect to gateway
			_gateway.connect( "http://localhost:8000/square/gateway/");

			// This var holds the data we want to pass to the remote service.
			var param:String = "Hello World!";

			// Set responder property to the object and methods that will receive the 
			// result or fault condition that the service returns.
			var responder:Responder = new Responder( onResult, onFault );

			// Call remote service to fetch data
			_gateway.call( "square.echo", responder, param );
		}

		// Result handler method 
		private function onResult( result:Object ): void {
			var myData:String = result.toString();
			trace( result );// prints "Hello World!"
			trace(myData)
		}
		// Fault handler method displays error message 
		private function onFault( error:Object ): void {
			// Notify the user of the problem
			for (var d:String in error) {
				trace(error[d] + "\n") 
			}
		}

	}
}