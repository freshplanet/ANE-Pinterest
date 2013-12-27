package com.freshplanet.pinterest.functions;

import android.content.Intent;
import android.net.Uri;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.pinterest.Extension;

public class PinterestOpenSlugFromUserFunction implements FREFunction {

	public PinterestOpenSlugFromUserFunction() {
	}

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		
		String slug = null;
		String username = null;
        try
        {
        	slug = arg1[0].getAsString();
        	username = arg1[1].getAsString();
        }
        catch (Exception e)
        {
                Extension.log("Error - open slug - Couldn't retrieve Actionscript parameters. Exception message: " + e.getMessage() + ". See \"adb logcat\" for stack trace.");
                e.printStackTrace();
                return null;
        }

		
		if (slug != null && username != null)
		{
			Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("pinterest://www.pinterest.com/"+username+"/"+slug+"/"));
			arg0.getActivity().startActivity(browserIntent);
		}
		return null;
	}

}
