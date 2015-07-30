//
//  ViewController.m
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Start.h"
#import "Map.h"
#import "Register.h"

@interface Start ()

@end

@implementation Start
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
}
//-------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------------------------------------------------------------
- (void)initController {
    [self playVideo];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNotificationReceivedStart) name:@"NotificationReceivedStart" object:nil];
        
    //Location
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyBest;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.lblSettings.layer.borderColor      = [UIColor whiteColor].CGColor;
    self.lblSettings.layer.borderWidth      = 1;
    self.lblSettings.clipsToBounds          = YES;
    self.lblSettings.layer.cornerRadius     = 8;
    
    self.lblStart.layer.borderColor         = [UIColor whiteColor].CGColor;
    self.lblStart.layer.borderWidth         = 1;
    self.lblStart.clipsToBounds             = YES;
    self.lblStart.layer.cornerRadius        = 8;
    
    //NSDictionary *dict = [Declarations sendCustomNotification];
}
//-------------------------------------------------------------------------------
-(void)didNotificationReceivedStart {
    print(NSLog(@"didNotificationReceivedStart"))
    UITabBarController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TabBarMap"];
    [self presentViewController:vc animated:YES completion:nil];
}
/**********************************************************************************************/
#pragma mark - Video method
/**********************************************************************************************/
-(void)playVideo {
    //Play video
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"video_children" ofType:@"mp4"];
    NSURL *videoUrl     = [NSURL fileURLWithPath:videoPath];
    
    self.moviePlayer    =[[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
    [self.moviePlayer.view setFrame:CGRectMake(-100, 0, 1136, 568)];
    
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer setShouldAutoplay:YES];
    [self.moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self.vVideo addSubview:self.moviePlayer.view];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidBecomeActiveNotification object:[UIApplication sharedApplication] queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self.moviePlayer play];
    }];
}
/**********************************************************************************************/
#pragma mark - Action methods
/**********************************************************************************************/
- (IBAction)btnSettingsPressed:(id)sender {
    Register *vc       = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Register"];
    [self presentViewController:vc animated:YES completion:nil];
}
//-------------------------------------------------------------------------------
- (IBAction)btnStartPressed:(id)sender {
    UITabBarController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TabBarMap"];
    [self presentViewController:vc animated:YES completion:nil];
}
/**********************************************************************************************/
#pragma mark - Localization
/**********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            NSString *addressName = [placemark name];
            NSString *city = [placemark locality];
            NSString *administrativeArea = [placemark administrativeArea];
            NSString *country  = [placemark country];
            NSString *countryCode = [placemark ISOcountryCode];
            NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
            /*self.lblCountry.text = country;
             self.lblName.text = addressName;
             self.lblName.adjustsFontSizeToFitWidth = YES;*/
        }
        
        mlatitude = self.locationManager.location.coordinate.latitude;
        mlongitude = self.locationManager.location.coordinate.longitude;
        NSLog(@"mlatitude = %f", mlatitude);
        NSLog(@"mlongitude = %f", mlongitude);
        if (miLocalizeState == nLocalizing) {
            miLocalizeState = nLocalized;
        }
    }];
    
}
@end
