//
//  SlidingViewController.h
//  DubaiPolice
//
//  Created by Faizan Ali on 12/10/13.
//  Copyright (c) 2013 Advansoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "SideMenuController.h"

@interface SlidingViewController : IIViewDeckController {
    
}

+ (void) openMenu;
+ (void) closeMenu;
+ (void) toggleMenu;
+ (void) cancelTouchesForClass:(Class)name;

@end