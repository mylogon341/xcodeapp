//
//  HomeViewController.h
//  TableView
//
//  Created by James Miller on 12/05/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIAlertViewDelegate>

{

    IBOutlet UIImageView *banner;
    IBOutlet UITextView *homeText;
    __weak IBOutlet NSLayoutConstraint *homeTextBottomConstraint;
    BOOL statusBarHidden;
}
- (void)checkForWIFIConnection;

//@property (nonatomic, assign) CGFloat extraColorLayerOpacity UI_APPEARANCE_SELECTOR;

@property(strong, nonatomic) UITextView *homeText;
@end
