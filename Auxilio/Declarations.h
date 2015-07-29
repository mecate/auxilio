//
//  Declarations.h
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <Foundation/Foundation.h>
#define         nLocalizing     0
#define         nLocalized      1

//Debug
#define nDebugEnable        1
#define print(x)            if(nDebugEnable){(x);}

//Localization variables
extern float    mlatitude;
extern float    mlongitude;

@interface Declarations : NSObject

@end
