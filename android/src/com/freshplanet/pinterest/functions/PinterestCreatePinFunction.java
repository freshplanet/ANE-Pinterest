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
import com.pinterest.pinit.PinIt;

public class PinterestCreatePinFunction implements FREFunction {

	public PinterestCreatePinFunction() {
	}

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		
		String imageUrl = null;
		String sourceUrl = null;
		String description = null;
        try
        {
        	imageUrl = arg1[0].getAsString();
        	sourceUrl = arg1[1].getAsString();
        	description = arg1[2].getAsString();

        }
        catch (Exception e)
        {
                Extension.log("Error - create pin - Couldn't retrieve Actionscript parameters. Exception message: " + e.getMessage() + ". See \"adb logcat\" for stack trace.");
                e.printStackTrace();
                return null;
        }

		
		if (false) // this is not working anymore...
		{
			PinIt pinIt = new PinIt();
			pinIt.setImageUrl(imageUrl);
			pinIt.setUrl(sourceUrl); // optional 
			pinIt.setDescription(description); // optional 
			pinIt.doPinIt(arg0.getActivity());
		} else // use the web version instead
		{
			String shareUrl = "http://www.pinterest.com/pin/create/button/?media="+imageUrl+"&description="+description+"&url="+sourceUrl;
			Intent myIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(shareUrl));
			arg0.getActivity().startActivity(myIntent);
		}

		return null;
	}

}
