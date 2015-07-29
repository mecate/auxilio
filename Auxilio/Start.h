//
//  ViewController.h
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 29/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Start : UIViewController
//Objects
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) IBOutlet UIView *vVideo;
@property (strong, nonatomic) IBOutlet UILabel *lblSettings;
@property (strong, nonatomic) IBOutlet UIButton *btnSettings;
@property (strong, nonatomic) IBOutlet UILabel *lblStart;
@property (strong, nonatomic) IBOutlet UIButton *btnStart;

//Actions
- (IBAction)btnSettingsPressed:(id)sender;
- (IBAction)btnStartPressed:(id)sender;


@end

