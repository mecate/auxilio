//
//  ViewController.m
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Start.h"

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
    
    self.lblSettings.layer.borderColor  = [UIColor whiteColor].CGColor;
    self.lblSettings.layer.borderWidth  = 1;
    self.lblSettings.clipsToBounds      = YES;
    self.lblSettings.layer.cornerRadius = 8;
    
    self.lblStart.layer.borderColor     = [UIColor whiteColor].CGColor;
    self.lblStart.layer.borderWidth     = 1;
    self.lblStart.clipsToBounds         = YES;
    self.lblStart.layer.cornerRadius    = 8;
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
}

- (IBAction)btnStartPressed:(id)sender {
}
@end
