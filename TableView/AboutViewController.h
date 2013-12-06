//
//  AboutViewController.h
//  TableView
//
//  Created by James Miller on 12/05/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

//@class known;

@interface AboutViewController : UIViewController <UIScrollViewDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
{
 
    IBOutlet UIScrollView *scroller;
    UIWebView *uiWebView;

}

- (IBAction)donate:(id)sender;
- (IBAction)tweet:(id)sender;
- (IBAction)followT:(id)sender;

- (IBAction)failbook:(id)sender;
- (IBAction)report:(id)sender;
- (IBAction)issues:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong) IBOutlet UIView *contentView;

//@property (nonatomic, strong) known *knownView;


@end
