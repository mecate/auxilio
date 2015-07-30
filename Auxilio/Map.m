//
//  Map.m
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Map.h"
#import "Start.h"
@import GoogleMaps;

@interface Map () {
GMSMapView          *mapView;
GMSMarker           *markerLocation;
GMSCameraPosition   *camera;
}
@end

@implementation Map
/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    //[self initPlaces];
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
    
    self.imgUser.layer.borderColor     = [UIColor clearColor].CGColor;
    self.imgUser.layer.borderWidth     = 1;
    self.imgUser.clipsToBounds         = YES;
    self.imgUser.layer.cornerRadius    = 40;
    
    self.vData.layer.borderColor     = [UIColor clearColor].CGColor;
    self.vData.layer.borderWidth     = 1;
    self.vData.clipsToBounds         = YES;
    self.vData.layer.cornerRadius    = 8;
}
//-------------------------------------------------------------------------------
- (IBAction)btnMenuPressed:(id)sender {
    Start *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Start"];
    [self presentViewController:vc animated:YES completion:nil];
}
//-------------------------------------------------------------------------------
- (IBAction)btnSharePressed:(id)sender {
    NSString                    *stMsg;
    NSArray                     *aItems;
    UIImage                     *imgShare;
    UIActivityViewController    *aVC;
    
    imgShare    = [UIImage imageNamed:@"userDummy.jpg"];
    NSString    *stGoogleMaps = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@,%@", mstNotificationLatitude, mstNotificationLongitude];
    stMsg       = [@"VIA Auxilio: " stringByAppendingString:mstNotificationUserName];
    stMsg       = [stMsg stringByAppendingString:@" needs HELP. Last known location: "];
    stMsg       = [stMsg stringByAppendingString:stGoogleMaps];
    aItems      = @[imgShare, stMsg];
    aVC         = [[UIActivityViewController alloc] initWithActivityItems:aItems applicationActivities:nil];
    aVC.excludedActivityTypes = [NSArray arrayWithObjects:UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeAirDrop,UIActivityTypeSaveToCameraRoll, nil];
    
    [self presentViewController:aVC animated:YES completion:nil];
}
//-------------------------------------------------------------------------------
-(void)didNotificationReceived {
    print(NSLog(@"didNotificationReceivedInMaps"))
    [self paintMap];
    [self paintMarker];
    self.lblName.text       = mstNotificationUserName;
    self.lblTime.text       = mstNotificationDate;
    self.lblStatus.text     = mstNotificationStatus;
    
    if ([mstNotificationStatus isEqual:@"OK"]) {
        self.lblStatus.textColor = [UIColor greenColor];
    }
    else {
        self.lblStatus.textColor = [UIColor redColor];
    }
    self.vUser.hidden       = NO;
    self.vShare.hidden      = NO;
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
    float latitude  = [mstNotificationLatitude floatValue];
    float longitude = [mstNotificationLongitude floatValue];

    camera                      = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:14.0];
    mapView                     = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame               = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-50);
    mapView.myLocationEnabled   = YES;
    
    [self.view addSubview:mapView];
    [self.view bringSubviewToFront:self.vUser];
    [self.view bringSubviewToFront:self.vShare];
    //[self.view bringSubviewToFront:self.lblCountry];
}
//------------------------------------------------------------
- (void) paintMarker {
    GMSMarker *marker       = [[GMSMarker alloc] init];
    marker.position         = camera.target;
    marker.title            = mstNotificationUserName;
    marker.snippet          = @"Status: OK";
    marker.appearAnimation  = kGMSMarkerAnimationPop;
    marker.map = mapView;
    
    /*CLLocationCoordinate2D position;
    NSLog(@"maPlacesTitle.count %d", (int)maPlacesTitle.count);
    for (int i = 0; i<maPlacesTitle.count; i++)
    {
        CGFloat lat                     = (CGFloat)[maPlacesLat[i] floatValue];
        CGFloat lng                     = (CGFloat)[maPlacesLng[i] floatValue];
        NSLog(@"Marker lat %f, long %f", lat, lng);
        position                        = CLLocationCoordinate2DMake(lat, lng);
        markerLocation                  = [GMSMarker markerWithPosition:position];
        markerLocation.icon             = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        markerLocation.title            = maPlacesTitle[i];
        markerLocation.snippet          = maPlacesSnippet[i];
        markerLocation.appearAnimation  = kGMSMarkerAnimationPop;
        markerLocation.map              = mapView;
    }*/
}

@end
