//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////

package com.freshplanet.ane.AirPinterest
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	public class AirPinterest extends EventDispatcher
	{
		// --------------------------------------------------------------------------------------//
		//																						 //
		// 									   PUBLIC API										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//
		
		/** AirPinterest is supported on iOS and Android devices. */
		public static function get isSupported() : Boolean
		{
			return Capabilities.manufacturer.indexOf("iOS") != -1 || Capabilities.manufacturer.indexOf("Android") != -1;
		}
		
		public function AirPinterest()
		{
			if (!_instance)
			{
				_context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				if (!_context)
				{
					throw Error("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
					return;
				}
				_context.addEventListener(StatusEvent.STATUS, onStatus);
				
				_instance = this;
			}
			else
			{
				throw Error("This is a singleton, use getInstance(), do not call the constructor directly.");
			}
		}
		
		public static function getInstance() : AirPinterest
		{
			return _instance ? _instance : new AirPinterest();
		}
		
		public function canPin():Boolean
		{
			if (!isSupported) return false;
			
			return _context.call("canPin") as Boolean;
		}
		
		public function init(clientId:String, urlSchemeSuffix:String = null):void
		{
			if (!isSupported) return;
			
			if (urlSchemeSuffix != null)
			{
				_context.call("init", clientId, urlSchemeSuffix)
			} else
			{
				_context.call("init", clientId)
			}
		}
		
		public function createPin(imageUrl:String, sourceUrl:String, description:String):void
		{
			if (!isSupported) return;
			
			_context.call("createPin", imageUrl, sourceUrl, description);
		}
		
		public function openPin(identifier:String):void
		{
			if (!isSupported) return;
			
			_context.call("openPin", identifier);
		}
		
		public function openUser(username:String):void
		{
			if (!isSupported) return;
			
			_context.call("openUser", username);
		}
		
		public function openSlugFromUser(slug:String, username:String):void
		{
			if (!isSupported) return;
			
			_context.call("openSlugFromUser", slug, username);
		}
		
		
		
		
		// --------------------------------------------------------------------------------------//
		//																						 //
		// 									 	PRIVATE API										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//
		
		private static const EXTENSION_ID : String = "com.freshplanet.AirPinterest";
		
		private static var _instance : AirPinterest;
		
		private var _context : ExtensionContext;
		
		
		private function onStatus( event : StatusEvent ) : void
		{
			if (event.code == "CLICK")
			{
			}
		}
	}
}