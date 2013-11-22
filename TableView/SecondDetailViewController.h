//
//  SecondDetailViewController.h
//  TableView
//
//  Created by luke on 27/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
@class RunDetail;
@interface SecondDetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{

    IBOutlet UITextView *runnersInfo;
    IBOutlet UIPickerView *secondPicker;
    IBOutlet UIBarButtonItem *playA;
    NSUInteger selectedRow;
    NSUInteger numberOfVideoLinks;
    NSUInteger currentPlayingPart;
    CGRect runnersInfoOriginalFrame;
    BOOL isPlayingAll;
}

@property (strong, nonatomic) UIBarButtonItem *playA;
@property (strong, nonatomic) RunDetail *run;
@property (strong, nonatomic) RunDetail *vids;
@property (nonatomic, strong) MPMoviePlayerController *mediaPlayer;
@property (nonatomic, strong) AVQueuePlayer *qPlay;

@end
