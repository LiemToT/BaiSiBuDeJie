//
//  LYLoginRegistViewController.m
//  百思不得姐OC
//
//  Created by linyi on 7/4/16.
//  Copyright © 2016 linyi. All rights reserved.
//

#import "LYLoginRegistViewController.h"

@interface LYLoginRegistViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@end

@implementation LYLoginRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)change:(UIButton *)sender {
    if (self.leftConstraint.constant == 0) { //处于登录界面
        self.leftConstraint.constant = -self.view.ly_width;
        self.changeButton.selected = YES;
    } else {
        self.leftConstraint.constant = 0;
        self.changeButton.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    [self.view endEditing:YES];
}

- (IBAction)close {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
