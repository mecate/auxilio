//
//  Map.h
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Declarations.h"
#import <CoreLocation/CoreLocation.h>
#import <Pushwoosh/PushNotificationManager.h>

@interface Map : UIViewController<CLLocationManagerDelegate, PushNotificationDelegate>
//Objects
@property (strong, nonatomic)   CLLocationManager   *locationManager;
@property (strong, nonatomic)   CLLocation          *location;

//Actions
- (IBAction)btnMenuPressed:(id)sender;

@end
