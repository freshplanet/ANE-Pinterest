Air Native Extension for Pinterest (iOS + Android)
======================================

This is an [Air native extension](http://www.adobe.com/devnet/air/native-extensions-for-air.html) for pinning pictures into Pinterest on iOS and Android. It has been developed by [FreshPlanet](http://freshplanet.com).


Installation
---------

The ANE binary (AirPinterest.ane) is located in the *bin* folder. You should add it to your application project's Build Path and make sure to package it with your app (more information [here](http://help.adobe.com/en_US/air/build/WS597e5dadb9cc1e0253f7d2fc1311b491071-8000.html)).

This ANE requires the Pinterest app to be installed on the device.

You need to go to the [Pinterest developer website](http://developers.pinterest.com/ios/), and register for a client id.

Then, in your application description, you will have to add this new url scheme (if you are working on iOS):

```xml
<iPhone>
    

    <InfoAdditions><![CDATA[
		<key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>pin<clientid></string>
				</array>
			</dict>
		</array>

    ]]></InfoAdditions>

</iPhone>
```


Usage
-----


```actionscript

// init Pinterest SDK
AirPinterest.getInstance().init("CLIENT_ID");

// pin a picture
if (AirPinterest.canPin())
{
	AirPinterest.createPin(imageUrl, sourceUrl, description);
}

// You can also open the Pinterest app to:
// - a specific pin
AirPinterest.openPin(pinId);

// - a specific pinterest user
AirPinterest.openUser(username);

// - a specific board
AirPinterest.openSlugFromUser(slug, username);
```

Build script
---------

Should you need to edit the extension source code and/or recompile it, you will find an ant build script (build.xml) in the *build* folder:

```bash
cd /path/to/the/ane

# Setup build configuration
cd build
mv example.build.config build.config
# Edit build.config file to provide your machine-specific paths

# Build the ANE
ant
```


Authors
------

This ANE has been written by Thibaut Crenn. It belongs to [FreshPlanet Inc.](http://freshplanet.com) and is distributed under the [Apache Licence, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).


Join the FreshPlanet team - GAME DEVELOPMENT in NYC
------

We are expanding our mobile engineering teams.

FreshPlanet is a NYC based mobile game development firm and we are looking for senior engineers to lead the development initiatives for one or more of our games/apps. We work in small teams (6-9) who have total product control.  These teams consist of mobile engineers, UI/UX designers and product experts.


Please contact Tom Cassidy (tcassidy@freshplanet.com) or apply at http://freshplanet.com/jobs/
