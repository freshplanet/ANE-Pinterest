//
//  AirPinterest.m
//  AirPinterest
//
//  Created by Thibaut Crenn on 12/26/13.
//  Copyright (c) 2013 Thibaut Crenn. All rights reserved.
//

#import "AirPinterest.h"

static NSString* pinterestClientId = nil;
static NSString* pinterestSuffix = nil;
static Pinterest *pinterest = nil;
static NSURL* imageUrl;
static NSURL* sourceUrl;
static NSString* description;
static dispatch_once_t onceToken;


DEFINE_ANE_FUNCTION(initPinterest)
{
    pinterestClientId = FPANE_FREObjectToNSString(argv[0]);
    pinterestSuffix = nil;
    if (argc > 1)
    {
        pinterestSuffix = FPANE_FREObjectToNSString(argv[1]);
    }
    return nil;
}


DEFINE_ANE_FUNCTION(canPin)
{
    if (!pinterest)
    {
        dispatch_once(&onceToken, ^{
            pinterest = [[Pinterest alloc] initWithClientId:[pinterestClientId copy]];
        });
    }
    return FPANE_BOOLToFREObject(pinterest != nil ? [pinterest canPinWithSDK] : NO);
}



DEFINE_ANE_FUNCTION(createPin)
{
    if (!pinterest)
    {
        dispatch_once(&onceToken, ^{
            pinterest = [[Pinterest alloc] initWithClientId:[pinterestClientId copy]];
        });
    }
    NSString *imagePath = FPANE_FREObjectToNSString(argv[0]);
    NSString *sourcePath = FPANE_FREObjectToNSString(argv[1]);
    description = FPANE_FREObjectToNSString(argv[2]);
    
    @try {
        if ([pinterest canPinWithSDK])
        {
            imageUrl  = [NSURL URLWithString:imagePath];
            sourceUrl = [NSURL URLWithString:sourcePath];
            [pinterest createPinWithImageURL:[imageUrl copy] sourceURL:[sourceUrl copy] description:[description copy]];
        } else
        {
            NSLog(@"Cannot create Pin");
        }
    }
    @catch (NSException *exception) {
       NSLog(@"Exception: %@", exception);
    }
    return nil;
}

DEFINE_ANE_FUNCTION(openPin)
{
    if (!pinterest)
    {
        dispatch_once(&onceToken, ^{
            pinterest = [[Pinterest alloc] initWithClientId:[pinterestClientId copy]];
        });
    }
    NSString *pinId = FPANE_FREObjectToNSString(argv[0]);
    [pinterest openPinWithIdentifier:pinId];
    return nil;
}

DEFINE_ANE_FUNCTION(openUser)
{
    if (!pinterest)
    {
        dispatch_once(&onceToken, ^{
            pinterest = [[Pinterest alloc] initWithClientId:[pinterestClientId copy]];
        });
    }
    NSString *username = FPANE_FREObjectToNSString(argv[0]);
    [pinterest openUserWithUsername:username];
    return nil;
}

DEFINE_ANE_FUNCTION(openSlugFromUser)
{
    if (!pinterest)
    {
        dispatch_once(&onceToken, ^{
            pinterest = [[Pinterest alloc] initWithClientId:[pinterestClientId copy]];
        });
    }
    NSString *slug = FPANE_FREObjectToNSString(argv[0]);
    NSString *username = FPANE_FREObjectToNSString(argv[1]);
    [pinterest openBoardWithSlug:slug fromUser:username];
    return nil;
}



void AirPinterestContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx,
                                   uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    // Register the links btwn AS3 and ObjC. (dont forget to modify the nbFuntionsToLink integer if you are adding/removing functions)
    NSInteger nbFuntionsToLink = 6;
    *numFunctionsToTest = nbFuntionsToLink;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * nbFuntionsToLink);
    
    func[0].name = (const uint8_t*) "init";
    func[0].functionData = NULL;
    func[0].function = &initPinterest;
    
    func[1].name = (const uint8_t*) "canPin";
    func[1].functionData = NULL;
    func[1].function = &canPin;
    
    func[2].name = (const uint8_t*) "createPin";
    func[2].functionData = NULL;
    func[2].function = &createPin;
    
    func[3].name = (const uint8_t*) "openPin";
    func[3].functionData = NULL;
    func[3].function = &openPin;
    
    func[4].name = (const uint8_t*) "openUser";
    func[4].functionData = NULL;
    func[4].function = &openUser;
    
    func[5].name = (const uint8_t*) "openSlugFromUser";
    func[5].functionData = NULL;
    func[5].function = &openSlugFromUser;
    
    *functionsToSet = func;
}

void AirPinterestContextFinalizer(FREContext ctx) { }

void AirPinterestInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &AirPinterestContextInitializer;
	*ctxFinalizerToSet = &AirPinterestContextFinalizer;
}

void AirPinterestFinalizer(void *extData) { }