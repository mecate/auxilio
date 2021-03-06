//
//  Declarations.h
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SBJson.h"
#define         nLocalizing     0
#define         nLocalized      1

//Debug
#define nDebugEnable        1
#define print(x)            if(nDebugEnable){(x);}

//Web services modes
#define nGET        0
#define nPOST       1

//Localization variables
extern float    mlatitude;
extern float    mlongitude;
extern int      miLocalizeState;
extern NSString *mstNotificationMessage;

//User
extern NSString *mstUserName;

extern NSString *mstNotificationUserName;
extern NSString *mstNotificationStatus;
extern NSString *mstNotificationLatitude;
extern NSString *mstNotificationLongitude;
extern NSString *mstNotificationDate;
extern NSString *mstNotificationStatus;

@interface Declarations : NSObject
+ (NSDictionary *)sendNotification;
+ (NSDictionary *)sendCustomNotification:(NSString *)notificationMessage andStatus:(NSString *)status;
@end
