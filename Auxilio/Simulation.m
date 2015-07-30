//
//  Simulation.m
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 30/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Simulation.h"
#import "Start.h"
@import GoogleMaps;

@interface Simulation ()
{
GMSMapView          *mapView;
GMSMarker           *markerLocation;
GMSCameraPosition   *camera;

}
@end

@implementation Simulation
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    [self paintMap];
    //[self paintMarker];
}
//-------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------------------------------------------------------------
- (void)initController {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNotificationReceived) name:@"NotificationReceived" object:nil];
    
    self.lblStatus.layer.borderColor    = [UIColor clearColor].CGColor;
    self.lblStatus.layer.borderWidth    = 1;
    self.lblStatus.clipsToBounds        = YES;
    self.lblStatus.layer.cornerRadius   = 8;
    self.lblStatus.text                 = @"Simulated Status: Save";
    
    self.vLoading.layer.borderColor     = [UIColor clearColor].CGColor;
    self.vLoading.layer.borderWidth     = 1;
    self.vLoading.clipsToBounds         = YES;
    self.vLoading.layer.cornerRadius    = 8;
}
//-------------------------------------------------------------------------------
- (IBAction)btnMenuPressed:(id)sender {
    Start *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Start"];
    [self presentViewController:vc animated:YES completion:nil];
}
//-------------------------------------------------------------------------------
- (IBAction)btnHelpPressed:(id)sender {
    [self.vActivityIndicator startAnimating];
    self.vLoading.hidden            = NO;
    self.lblStatus.text             = @"Simulated Status: I need help";
    NSOperationQueue *queue         = [NSOperationQueue new];
    NSInvocationOperation *opSend   = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(opSendHelp) object:nil];
    [queue addOperation:opSend];
}
//-------------------------------------------------------------------------------
- (IBAction)btnOKPressed:(id)sender {
    [self.vActivityIndicator startAnimating];
    self.vLoading.hidden            = NO;
    self.lblStatus.text             = @"Simulated Status: Save";
    NSOperationQueue *queue         = [NSOperationQueue new];
    NSInvocationOperation *opSend   = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(opSendOK) object:nil];
    [queue addOperation:opSend];
}
//-------------------------------------------------------------------------------
-(void)didNotificationReceived {
    print(NSLog(@"didNotificationReceivedInMaps"))
}
//-------------------------------------------------------------------------------
- (void) onPushAccepted:(PushNotificationManager *)pushManager withNotification:(NSDictionary *)pushNotification {
    print(NSLog(@"onPushAccepted"))
}
/**********************************************************************************************/
#pragma mark - Maps methods
/**********************************************************************************************/
- (void) paintMap {
    [mapView removeFromSuperview];
    camera                      = [GMSCameraPosition cameraWithLatitude:mlatitude longitude:mlongitude zoom:14.0];
    mapView                     = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame               = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-50);
    mapView.myLocationEnabled   = YES;
    
    [self.view addSubview:mapView];
    [self.view bringSubviewToFront:self.vHelp];
    [self.view bringSubviewToFront:self.vOK];
    [self.view bringSubviewToFront:self.vLoading];
    [self.view bringSubviewToFront:self.lblStatus];
}
//------------------------------------------------------------
- (void) paintMarker {
    GMSMarker *marker       = [[GMSMarker alloc] init];
    marker.position         = camera.target;
    marker.title            = @"My child: Walter Jr.";
    marker.snippet          = @"Status: OK";
    marker.appearAnimation  = kGMSMarkerAnimationPop;
    marker.map = mapView;
}
/**********************************************************************************************/
#pragma mark - Operation methods
/**********************************************************************************************/
-(void)opSendHelp {
    print(NSLog(@"opSendHelp"))
    [Declarations sendCustomNotification:@" needs help!" andStatus:@"HELP"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.vLoading.hidden = YES;
    });
}
//------------------------------------------------------------
-(void)opSendOK {
    print(NSLog(@"opSendOK"))
    [Declarations sendCustomNotification:@" is now save" andStatus:@"OK"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.vLoading.hidden = YES;
    });
}
@end
