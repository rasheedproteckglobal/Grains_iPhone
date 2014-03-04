//
//  SplashActivityViewController.m
//  DubaiPolice
//
//  Created by Advansoft on 12/16/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import "SplashActivityViewController.h"
#import "LanguageViewController.h"

#import "DPSplashImageRequest.h"

@interface SplashActivityViewController ()

@end

@implementation SplashActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    if([Common isIPhone4]){
//        imageViewBG.image = [UIImage imageNamed:@"splashIP4.png"];
//    }
//    else{
//        imageViewBG.image = [UIImage imageNamed:@"splash.png"];
//    }

    [self performSelector:@selector(showRootController) withObject:nil afterDelay:1.5];
    
//    request = [[DPMasterRequest alloc ] init];
//    [request makeRequest:self finishSel:nil failSel:nil];
//    
//    splashRequest = [[DPSplashImageRequest alloc]init];
//    [splashRequest makeRequest:self finishSel:@selector(splashRequestRecieved:withResponse:) failSel:@selector(splashRequestFailed:withResponse:)];
//
//    SplashImage *splashImage = [[DataManager sharedInstance] getSplashImage];
//    if (splashImage) {
//        [imageViewSplash setImageWithURL:[NSURL URLWithString:splashImage.imagePath] cache:YES];
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) showRootController {
    BOOL val = [[[NSUserDefaults standardUserDefaults] valueForKey:kNotFirstTime] boolValue];
    NSString *controllerName = nil;
    if(val) {
        controllerName = @"SlidingViewController";
    }
    else {
        controllerName = @"LanguageViewController";
    }
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:controllerName];
    [self.navigationController pushViewController:vc animated:YES];
}
//
//- (void)splashRequestRecieved:(DPRequest *)request withResponse:(id)response {
//
//    NSArray *array = (NSArray*)response;
//    
//    SplashImage *splashImage = [[DataManager sharedInstance]getSplashImage];
//    if (splashImage) {
//        [imageViewSplash setImageWithURL:[NSURL URLWithString:splashImage.imagePath] cache:YES];
//    }
//
////    if (array && [array count] > 0) {
////        SplashImage *splashImage = [array objectAtIndex:0];
////        [imageViewSplash setImageWithURL:[NSURL URLWithString:splashImage.imagePath] cache:YES];
////    }
//    
//}
//
//- (void)splashRequestFailed:(DPRequest *)request withResponse:(id)response {
//
//}
//
////- (BOOL)shouldAutorotate {
////    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
////        return NO;
////    }
////    return YES;
////}

@end
