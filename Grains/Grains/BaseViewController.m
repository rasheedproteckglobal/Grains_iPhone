//
//  BaseViewController.m
//  DIB
//
//  Created by Muhammad Mosib Asad on 6/11/13.
//  Copyright (c) 2013 Muhammad Mosib Asad. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{

}

@end



@implementation BaseViewController

- (void) loadView {
    [super loadView];
   }

- (void)viewDidLoad
{
    [super viewDidLoad];

    navBar = (DPNavBar*)[Common loadNibName:@"DPNavBar" owner:self options:nil];
    [navBar.buttonBack addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    [navBar.buttonMenu addTarget:self action:@selector(actionMenu:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:navBar];
    [self.view bringSubviewToFront:navBar];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}


#pragma mark -
#pragma mark Public Methods

- (void) setTitle:(NSString*)title {
    [navBar.labelTitle setText:title];
    navBar.labelTitle.adjustsFontSizeToFitWidth = YES;
    navBar.labelTitle.minimumFontSize = 0;
}

- (void) hideBackButton {
    [navBar.buttonBack setHidden:YES];
}

- (void) hideNavBar {
    navBar.hidden = YES;
}

- (void) showNavBar {
    navBar.hidden = NO;
}

#pragma mark -
#pragma mark Actions

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)actionMenu:(id)sender {
    [SlidingViewController toggleMenu];
}


#pragma mark -
#pragma mark Social Sharing Functions



@end
