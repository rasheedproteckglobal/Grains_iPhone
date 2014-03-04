//
//  DubaiPoliceViewController.m
//  DubaiPolice
//
//  Created by Faizan Ali on 12/9/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import "LanguageViewController.h"

#import "SlidingViewController.h"
#import "CustomAlertView.h"
#import "AppDelegate.h"

@interface LanguageViewController ()

@end

@implementation LanguageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    request = [[DPMasterRequest alloc ] init];
//    [request makeRequest:self finishSel:@selector(requestRecieved:withResponse:) failSel:@selector(requestFailed:withResponse:)];
    //[Common showLoader];
    
}



#pragma mark -
#pragma mark Actions

- (IBAction)actionLanguage:(id)sender {
    UIButton *button = (UIButton*)sender;
    int tag = button.tag;
    if(tag == ARABIC && AppLanguage != ARABIC) {
        [AppSettings setLanguage:ARABIC];
    }
    else {
        [AppSettings setLanguage:ENGLISH];
    }
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:kNotFirstTime];
    [[NSUserDefaults standardUserDefaults] synchronize];
    AppDelegate *delegate  = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [delegate loadStoryBoard];
}

- (IBAction)englishButton:(id)sender {
    [AppSettings setLanguage:ENGLISH];
    
}


- (IBAction)arabicButton:(id)sender {
    [AppSettings setLanguage:ENGLISH];
}


//- (void)requestRecieved:(DPRequest *)request withResponse:(id)response {
//    [Common hideLoader];    
//}
//
//
//- (void)requestFailed:(DPRequest *)request withResponse:(id)response {
//    [Common hideLoader];
//}



@end
