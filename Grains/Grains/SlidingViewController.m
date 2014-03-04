//
//  SlidingViewController.m
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import "SlidingViewController.h"


@interface SlidingViewController ()

@end

@implementation SlidingViewController

static SlidingViewController *slidingViewController = nil;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    slidingViewController = self;
    SideMenuController *controller =  [self.storyboard instantiateViewControllerWithIdentifier:@"SideMenuController"];
    UINavigationController *navController = [self.storyboard instantiateViewControllerWithIdentifier:@"GrainsNavigationController"];
    self.centerController = navController;
    self.rightController = controller;
    self.rightSize = 100;
    self.elastic = NO;

    self.openSlideAnimationDuration = 0.15;
    self.closeSlideAnimationDuration = 0.15;
}

//- (BOOL)shouldAutorotate {
//    return YES;
//}

//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationPortrait;
//}

+ (void) openMenu {
    [slidingViewController openRightViewAnimated:YES];
}

+ (void) closeMenu {
    [slidingViewController closeRightViewAnimated:true];
}

+ (void) toggleMenu {
    [slidingViewController toggleRightViewAnimated:true];
}

+ (void) cancelTouchesForClass:(Class)name {
    [slidingViewController disablePanOverViewsOfClass:name];
}

@end
