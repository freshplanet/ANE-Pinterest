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

package com.freshplanet.pinterest;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.freshplanet.pinterest.functions.PinterestCanPinFunction;
import com.freshplanet.pinterest.functions.PinterestCreatePinFunction;
import com.freshplanet.pinterest.functions.PinterestInitFunction;
import com.freshplanet.pinterest.functions.PinterestOpenPinFunction;
import com.freshplanet.pinterest.functions.PinterestOpenSlugFromUserFunction;
import com.freshplanet.pinterest.functions.PinterestOpenUserFunction;

public class ExtensionContext extends FREContext
{
	// Public API
	
	@Override
	public void dispose() { }

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		
		functionMap.put("init", new PinterestInitFunction());
		functionMap.put("canPin", new PinterestCanPinFunction());
		functionMap.put("createPin", new PinterestCreatePinFunction());
		functionMap.put("openPin", new PinterestOpenPinFunction());
		functionMap.put("openUser", new PinterestOpenUserFunction());
		functionMap.put("openSlugFromUser", new PinterestOpenSlugFromUserFunction());

		return functionMap;	
	}
	
}
