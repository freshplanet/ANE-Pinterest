//
//  AirPinterest.h
//  AirPinterest
//
//  Created by Thibaut Crenn on 12/26/13.
//  Copyright (c) 2013 Thibaut Crenn. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "FPANEUtils.h"
#import <Pinterest/Pinterest.h>

@interface AirPinterest : NSObject
@end
DEFINE_ANE_FUNCTION(initPinterest);
DEFINE_ANE_FUNCTION(canPin);
DEFINE_ANE_FUNCTION(createPin);
DEFINE_ANE_FUNCTION(openPin);
DEFINE_ANE_FUNCTION(openUser);
DEFINE_ANE_FUNCTION(openSlugFromUser);


// ANE Setup
void AirPinterestContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void AirPinterestContextFinalizer(FREContext ctx);
void AirPinterestInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void AirPinterestFinalizer(void *extData);
