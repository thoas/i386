/**
 *[description]
 *<p><H1>FBConsoleUtil Class</h1>
 *<p> Description : Class de communication pour debug sur la console firebug
 *<p>
 *
 *@author : Jérôme LEGOFF
 *@date :03-2008
 *@update :
 *@version : 0.1
 *
 *@usage	<pre>
 *			</pre>
 *
 *@todo		<pre>
 *
 *			</pre>
 **/

/// @cond
package com.dosites.debug {
/// @endcond
	/**
	 * Import
	**/
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;

	public class FBConsole {
		/**
		 * isWhitespace : analyse un caractere comme vide
		 * @param ch:String [ caractère a analyser comme vide ]
		 * @return Boolean
		 */
		public static function isFBConsole():Boolean {
			var firebug:Boolean = false

			var isBrowser: Boolean = ( Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn" );

			//trace ("isBrowser " + isBrowser);

			if ( isBrowser && ExternalInterface.available ){
				// check si firebug installé et ouvert
				if ( ExternalInterface.call( "function(){ return typeof window.console == 'object' && typeof console.firebug == 'string'}")){
					firebug = true;
					}
				}
			return firebug;
		}

		/**
		 * FBwrite : Ecrit dans la console firebug si celle si existe
		 * @param mess:String [ String a ecrire en console fireBug ]
		 */
		public static function FBwrite(mess:String="",consLevel:String="log"):void {
			if(isFBConsole()){
				ExternalInterface.call( "console."+consLevel , mess);
			}
		}

	}
}