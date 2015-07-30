//
//  Simulation.h
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 30/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Declarations.h"
#import <CoreLocation/CoreLocation.h>
#import <Pushwoosh/PushNotificationManager.h>

@interface Simulation : UIViewController<CLLocationManagerDelegate, PushNotificationDelegate>
//Objects
@property (strong, nonatomic)   CLLocationManager   *locationManager;
@property (strong, nonatomic)   CLLocation          *location;
@property (strong, nonatomic) IBOutlet UIView *vLoading;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *vActivityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;

@property (strong, nonatomic) IBOutlet UIView *vHelp;
@property (strong, nonatomic) IBOutlet UIView *vOK;

//Actions
- (IBAction)btnMenuPressed:(id)sender;
- (IBAction)btnHelpPressed:(id)sender;
- (IBAction)btnOKPressed:(id)sender;

@end
