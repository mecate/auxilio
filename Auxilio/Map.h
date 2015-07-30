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
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface Map : UIViewController<CLLocationManagerDelegate, PushNotificationDelegate>
//Objects
@property (strong, nonatomic)   CLLocationManager   *locationManager;
@property (strong, nonatomic)   CLLocation          *location;
@property (strong, nonatomic) IBOutlet UIView *vUser;
@property (strong, nonatomic) IBOutlet UIImageView *imgUser;
@property (strong, nonatomic) IBOutlet UIView *vData;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UIView *vShare;

//Actions
- (IBAction)btnMenuPressed:(id)sender;
- (IBAction)btnSharePressed:(id)sender;

@end
