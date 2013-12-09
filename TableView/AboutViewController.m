//
//  AboutViewController.m
//  TableView
//
//  Created by James Miller on 12/05/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "AboutViewController.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "AppDelegate.h"
#import "MasterViewController.h"
#import "HomeViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

//@synthesize knownView;
@synthesize scroller;
@synthesize aboutNavBar;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Info", @"Info");
    }
    return self;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    scroller.contentSize = CGSizeMake(320, 1180);
    self.contentView.backgroundColor = [UIColor blackColor] ;
        

}

- (IBAction)donate:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=C9TTCLA8A2MNU"]];
}


- (IBAction)followT:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/intent/user?screen_name=mylogon_"]];
    
}

- (IBAction)tweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"@mylogon_ #SDAApp Check it out on iOS - it's free! https://t.co/pi9quQwCtm"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}



- (IBAction)failbook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Check out 'SDA App' on iOS - it's free! https://t.co/pi9quQwCtm"];
        [controller addImage:[UIImage imageNamed:@"spotlight80.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");

    
    
    }
    
}


    
- (IBAction)report:(id)sender {    
    
    UIAlertView *errorView;
    
    errorView = [[UIAlertView alloc]
                 initWithTitle: NSLocalizedString(@"Logging", @"Logging")
                 message: NSLocalizedString(@"Please enter as much detail as you can about the error/ fault you have experienced. Thank you", @"Logging")
                 delegate: self
                 cancelButtonTitle: NSLocalizedString(@"OK", @"Logging") otherButtonTitles: @"It doesn't matter...", nil];
    errorView.tag = 101;
    
    
      [errorView show];
    
}

    - (IBAction)issues:(id)sender {
        
       
        
        UIViewController *webViewController = [[UIViewController alloc] init];
        
      
                                               
        
        uiWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
        
        [uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sdaapp.net/issues.rtf"]]];
        
[[NSURLCache sharedURLCache] removeAllCachedResponses];
        
        [webViewController.view addSubview: uiWebView];
        
    
        [self.navigationController pushViewController:webViewController animated:YES];
   

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        if (alertView.tag == 101) {
            
                NSLog(@"ok");
                
                // Email Subject
                NSString *emailTitle = @"ERROR LOG";
                // Email Content
                NSString *messageBody = @"";
                // To address
                NSArray *toRecipents = [NSArray arrayWithObject:@"speeddemosarchive.app@gmail.com"];
                
                MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                mc.mailComposeDelegate = self;
                [mc setSubject:emailTitle];
                [mc setMessageBody:messageBody isHTML:NO];
                [mc setToRecipients:toRecipents];
                
                // Present mail view controller on screen
                [self presentViewController:mc animated:YES completion:NULL];
            }
        else if (alertView.tag == 102)
            {

   
                NSLog(@"OK pressed");
            
                //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.sdaapp.net/issues.rtf"]];
      
}
    
    if (alertView.tag == 103) {
        
        NSLog(@"facebook ok");
        
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end







