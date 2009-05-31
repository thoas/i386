/**
 *[description]
 *<p><H1>FPSMeter Class</h1>
 *<p> Description :
 *<p> Class simple de calcul de Framerate
 *
 *@author : Jérôme LEGOFF
 *@date :14-2009
 *@update :
 *@version : 0.1
 *
 *@usage	<pre>
 *			// instanciation du FPS :
 *			_fps = new FPSMeter(stage);
 *			_fps.addEventListener(FPSMeter.FPS_UPDATE,onFpsEventHandler)
 *			_fps.start();
 *
 *			private function onFpsEventHandler(evtObj:Event):void{
 *				trace( "fps = " + _fps.getFPS() );
 *				// pour eviter la surcharge du trace... on trace dans firebug console
 *				FBConsole.FBwrite(String(_fps.getFPS()));
 *
 *			}
 *
 *		</pre>
 *
 *@todo		<pre>

 *			</pre>
 **/
/// @cond
package com.dosites.debug
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Simple class de mesure du framerate.
	 */
	public class FPSMeter extends EventDispatcher
	{
		// Properties /////////////////////////////////////////////////////////////////

		public static const FPS_UPDATE:String = "fpsUpdate";

		private var _stage:Stage;
		private var _timer:Timer;
		private var _fps:int;
		private var _isRunning:Boolean;

		// Constructor ////////////////////////////////////////////////////////////////

		/**
		 * Constructor
		 */
		public function FPSMeter(stage:Stage)
		{
			_stage = stage;
			_fps = 0;
			_isRunning = false;
		}

		// Public Methods /////////////////////////////////////////////////////////////

		/**
		 * Starts FPS meter.
		 */
		public function start(pollInterval:uint = 1000):void
		{
			if (!_isRunning)
			{
				_isRunning = true;
				_timer = new Timer(pollInterval, 0);
				_timer.addEventListener(TimerEvent.TIMER, onTimer);
				_stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				_timer.start();
			}
		}

		/**
		 * Stops FPS meter.
		 */
		public function stop():void
		{
			if (_isRunning)
			{
				_isRunning = false;
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER, onTimer);
				_stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				_timer = null;
			}
		}

		/**
		 * Retourne le FPS courant
		 * @return int [frame per seconds].
		 */
		public function getFPS():int
		{
			return _fps;
		}

		// Private Methods ////////////////////////////////////////////////////////////

		/**
		 * Handler timer .
		 * @private
		 */
		private function onTimer(event:TimerEvent):void
		{
			dispatchEvent(new Event(FPSMeter.FPS_UPDATE));
			_fps = 0;
		}

		/**
		 * Handler enterFrame.
		 * @private
		 */
		private function onEnterFrame(event:Event):void
		{
			_fps++;
		}
	}
}
