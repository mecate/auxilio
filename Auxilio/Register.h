//
//  Register.h
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 30/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register : UIViewController
//Objects
@property (strong, nonatomic) IBOutlet UITextField *txtName;


//Actions
- (IBAction)btnMenuPressed:(id)sender;
- (IBAction)btnSavePressed:(id)sender;



@end
