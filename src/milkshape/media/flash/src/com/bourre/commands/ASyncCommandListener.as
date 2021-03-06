/*
 * Copyright the original author or authors.
 * 
 * Licensed under the MOZILLA PUBLIC LICENSE, Version 1.1 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.bourre.commands
{
	import flash.events.Event;		

	/**
	 * Interface for objects which want to be notified of the end of execution
	 * of an asynchronous command.
	 * 
	 * @author Francis Bourre
	 */
	public interface ASyncCommandListener
	{
		/**
		 * Called when the command have completed its process.
		 * 
		 * @param	e	event dispatched by the command
		 */
		function onCommandEnd ( e : Event ) : void;
	}
}