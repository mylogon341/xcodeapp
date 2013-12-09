//
//  HomeViewController.m
//  TableView
//
//  Created by James Miller on 12/05/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "HomeViewController.h"
#import "Reachability.h"

@interface HomeViewController ()

@property (nonatomic, strong) CALayer *extraColorLayer;

@end

static CGFloat const kDefaultColorLayerOpacity = 0.5f;

@implementation HomeViewController
@synthesize homeText;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"Home");
    }
    return self;
}

/*
- (void)setBarTintColor:(UIColor *)barTintColor
{
    //[super setBarTintColor:barTintColor];
    if (self.extraColorLayer == nil) {
        // this all only applies to 7.0 - 7.0.2
        if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0.3" options:NSNumericSearch] == NSOrderedAscending) {
            self.extraColorLayer = [CALayer layer];
            self.extraColorLayer.opacity = self.extraColorLayerOpacity;
            [self.view.layer addSublayer:self.extraColorLayer];
        }
    }
    self.extraColorLayer.backgroundColor = barTintColor.CGColor;
}
*/
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self hometexts];
    [self checkReachability];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImage *header = [UIImage imageNamed:@"headerGray.jpg"];
    banner = [[UIImageView alloc] initWithImage:header];
    //[banner setFrame:self.view.frame];
    [banner setFrame:CGRectMake(0, 10, 320, 130)];
    [self.view addSubview:banner];
    
    
    
    self.homeText.backgroundColor = [UIColor colorWithRed:(124/255.0) green:(124/255.0) blue:(124/255.0) alpha:1] ;
    
    homeText.textColor = [UIColor whiteColor];
    
 // [homeText setFrame:CGRectMake(0, 135, 320, 400)];
 // [self.view addSubview:homeText];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        homeTextBottomConstraint.constant = 0; // This constraint is only needed on iOS 7.
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    if(statusBarHidden == NO)
    {
        self.navigationController.navigationBar.frame = CGRectOffset(self.navigationController.navigationBar.frame, 0.0, -20.0);
        statusBarHidden = YES;
        
    }
    

}

-(void)viewDidAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)hometexts
{
    
    if (self.homeText) {
        //Here we start the background loading
        dispatch_async(dispatch_queue_create("hometext", NULL), ^{
            NSError *error;
            //Here we load the text
            NSString *string = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://sdaapp.net/Text/hText.txt"]
                                                            encoding:NSUTF8StringEncoding
                                                               error:&error];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (error) NSLog(@"Something went wrong: %@",error);
                else {
                    homeText.text = string;
                }
                //We've now successfully set the text
                
            });
        });
    }
}


-(void)checkReachability
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    
    if(internetStatus == NotReachable) {
        UIAlertView *errorView;
        
        errorView = [[UIAlertView alloc]
                     initWithTitle: NSLocalizedString(@"Network error", @"Network error")
                     message: NSLocalizedString(@"Internet connection not found. Check your internets.", @"Network error")
                     delegate: self
                     cancelButtonTitle: NSLocalizedString(@"OK. I will", @"Network error") otherButtonTitles: nil];
        
        [errorView show];
    }
    [self checkForWIFIConnection];
}
-(void)checkForWIFIConnection
{

    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    if (netStatus!=ReachableViaWiFi)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No WIFI", @"AlertView")
                                                            message:NSLocalizedString(@"You have a complete lack of Wifi. It's advised", @"AlertView")
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Thanks for the tip!", @"AlertView")
                                                  otherButtonTitles: nil];
        [alertView show];
    }
    

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
