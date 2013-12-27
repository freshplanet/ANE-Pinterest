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

package com.freshplanet.pinterest.functions;

import android.content.Intent;
import android.net.Uri;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.pinterest.Extension;

public class PinterestOpenUserFunction implements FREFunction {

	public PinterestOpenUserFunction() {
	}

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		String username = null;
        try
        {
        	username = arg1[0].getAsString();
        }
        catch (Exception e)
        {
                Extension.log("Error - open user - Couldn't retrieve Actionscript parameters. Exception message: " + e.getMessage() + ". See \"adb logcat\" for stack trace.");
                e.printStackTrace();
                return null;
        }

		
		if (username != null)
		{
			Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("pinterest://www.pinterest.com/"+username+"/"));
			arg0.getActivity().startActivity(browserIntent);
		}
		
		return null;
	}

}
