//
//  Register.m
//  Auxilio
//
//  Created by Walter Gonzalez Domenzain on 30/07/15.
//  Copyright (c) 2015 Smartplace. All rights reserved.
//

#import "Register.h"
#import "Start.h"

@interface Register ()

@end

@implementation Register

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMenuPressed:(id)sender {
    Start *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Start"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btnSavePressed:(id)sender {
    mstUserName     = self.txtName.text;
    Start *vc       = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Start"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
