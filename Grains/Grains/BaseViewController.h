//
//  BaseViewController.h
//  DIB
//
//  Created by Muhammad Mosib Asad on 6/11/13.
//  Copyright (c) 2013 Muhammad Mosib Asad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPNavBar.h"

//#import <FacebookSDK/FacebookSDK.h>
//#import <Twitter/Twitter.h>
//#import <MessageUI/MessageUI.h>
//#import <MessageUI/MFMailComposeViewController.h>


@interface BaseViewController : UIViewController {
    DPNavBar *navBar;
}

- (void) hideNavBar;
- (void) showNavBar;
- (IBAction)actionBack:(id)sender;
- (void) setTitle:(NSString*)title;
- (void) hideBackButton;
- (IBAction)actionHome:(id)sender;
- (IBAction)actionMenu:(id)sender;
- (void) facebookShare:(NSString *)link name:(NSString *)name caption:(NSString *)caption picture:(NSString *)picture description:(NSString *)description;
-(void)tweetShare:(NSString *)tweetText attachmentUrl:(NSString*)attachmentUrl;
- (void) emailShare:(NSString*)emailText subject:(NSString*)subject attachmentImage:(UIImage*)attachmentImage attachmentImageTitle:(NSString*)attachmentImageTitle;
@end
