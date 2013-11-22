//
//  SecondDetailViewController.m
//  TableView
//
//  Created by luke on 27/04/2013.
//  Copyright (c) 2013 luke. All rights reserved.
//

#import "SecondDetailViewController.h"
#import "RunDetail.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface SecondDetailViewController ()
- (void)downloadText:(NSString *)link;
- (void)play;
- (void)playAll;
- (void)done;
@end

@implementation SecondDetailViewController
@synthesize run = _run;
@synthesize mediaPlayer = _mediaPlayer;
@synthesize qPlay = _qPlay;
@synthesize playA;
@synthesize vids = _vids;



- (void)setRun:(RunDetail *)newRun
{
    if (_run != newRun) {
        _run = newRun;
        [secondPicker reloadAllComponents];
        [self downloadText:self.run.commentsLink];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Play" style:UIBarButtonItemStyleBordered target:self action:@selector(play)];
    playA = [[UIBarButtonItem alloc] initWithTitle:@"Play All" style:UIBarButtonItemStyleBordered target:self action:@selector(playAll)];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil
                                   action:nil];
    [fixedSpace setWidth:30];
    
    NSArray *playArray = [[NSArray alloc] initWithObjects:addButton, fixedSpace, playA, nil];
    
    self.navigationItem.rightBarButtonItems = playArray;
    addButton.tintColor = [UIColor colorWithRed:(25/255.0) green:(200/250.0) blue:(110/255.0) alpha:1];
    playA.tintColor = [UIColor colorWithRed:(25/255.0) green:(100/250.0) blue:(180/255.0) alpha:1];

    isPlayingAll = NO;
    
    runnersInfoOriginalFrame = CGRectMake(0, 216, 320, 238);
}

- (void)viewWillDisappear:(BOOL)animated {
    [runnersInfo scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSURL *URL = [NSURL URLWithString:[[self.run.videoLinks objectForKey:@"Vid"] objectAtIndex:row]];
    [self.mediaPlayer setContentURL:URL];
    selectedRow = [pickerView selectedRowInComponent:0];
    [self done];
    [self performSelector:@selector(viewDidLoad) withObject:nil afterDelay:0.0];

}


- (void)willEnterFullscreen:(NSNotification*)notification {
    NSLog(@"willEnterFullscreen");
}

- (void)enteredFullscreen:(NSNotification*)notification {
    NSLog(@"enteredFullscreen");
}

- (void)willExitFullscreen:(NSNotification*)notification {
    NSLog(@"willExitFullscreen");
}

- (void)exitedFullscreen:(NSNotification*)notification {
    NSLog(@"exitedFullscreen");
    [_mediaPlayer.view removeFromSuperview];
    _mediaPlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
- (void)playbackFinished:(NSNotification*)notification {
    NSNumber* reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason intValue]) {
        case MPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackFinished. Reason: Playback Ended");
            break;
        case MPMovieFinishReasonPlaybackError:
            NSLog(@"playbackFinished. Reason: Playback Error");
            break;
        case MPMovieFinishReasonUserExited:
            NSLog(@"playbackFinished. Reason: User Exited");
            break;
        default:
            break;
    }
    [_mediaPlayer setFullscreen:NO animated:YES];
}
*/
- (void)play {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterFullscreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitFullscreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enteredFullscreen:) name:MPMoviePlayerDidEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitedFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    currentPlayingPart = selectedRow;
    NSURL *url = [NSURL URLWithString:[[self.run.videoLinks objectForKey:@"Vid"] objectAtIndex:currentPlayingPart]];
    UIGraphicsBeginImageContext(CGSizeMake(1,1));
    
    _mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    isPlayingAll = NO;
    _mediaPlayer.view.frame = self.view.frame;
    [self.view addSubview:_mediaPlayer.view];
    [_mediaPlayer setFullscreen:YES animated:YES];
    [_mediaPlayer play];
}


- (void)playAll {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterFullscreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitFullscreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enteredFullscreen:) name:MPMoviePlayerDidEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitedFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
     currentPlayingPart = selectedRow;
    NSURL *url = [NSURL URLWithString:[[self.run.videoLinks objectForKey:@"Vid"] objectAtIndex:currentPlayingPart]];
    UIGraphicsBeginImageContext(CGSizeMake(1,1));
    
    _mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
       isPlayingAll = YES;
    _mediaPlayer.view.frame = self.view.frame;
    [self.view addSubview:_mediaPlayer.view];
    [_mediaPlayer setFullscreen:YES animated:YES];
    [_mediaPlayer play];
}


- (void)done
{
    [_mediaPlayer stop];
    [_mediaPlayer.view removeFromSuperview];
    currentPlayingPart = 0;
    [self performSelector:@selector(viewDidLoad) withObject:nil afterDelay:0.0];

}



-(void)videoPlayBackDidFinish:(NSNotification*)aNotification {
    
   
  //  [_mediaPlayer setFullscreen:NO animated:YES];
    
   NSNumber* reason = [[aNotification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    switch ([reason intValue]) {
        case MPMovieFinishReasonPlaybackEnded:
        //Put code here to autoplay next one if you wanted
        if (isPlayingAll) {
            if (!(currentPlayingPart + 2 > numberOfVideoLinks)) {
                NSURL *url = [NSURL URLWithString:[[self.run.videoLinks objectForKey:@"Vid"] objectAtIndex:currentPlayingPart +=1]];
                [_mediaPlayer setContentURL:url];
                _mediaPlayer.movieSourceType = MPMovieSourceTypeUnknown;
                [_mediaPlayer play];
            } else {
                [self done];
            }
        } else {
            [self done];
        }
        break;
    case MPMovieFinishReasonPlaybackError:
        //Handle error maybe?
        [self done];
        break;
    case MPMovieFinishReasonUserExited:
        [self done];
        break;
    default:
        break;
  }
    
    if (_mediaPlayer == [aNotification object])
       [[NSNotificationCenter defaultCenter] removeObserver:self
                     name:MPMoviePlayerPlaybackDidFinishNotification object:self.mediaPlayer];
}

- (void)downloadText:(NSString *)link
{
    if (link) {
        //Here we start the background loading
        dispatch_async(dispatch_queue_create("LoadTxt", NULL), ^{
            NSError *error;
            //Here we load the text
            NSString *text = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:link]
                                                            encoding:NSUTF8StringEncoding
                                                               error:&error];
            //We've got the text now, got back to foreground
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (error) NSLog(@"Something went wrong: %@",error);
                else {
                    [runnersInfo reloadInputViews];
                    runnersInfo.text = text;
                    [runnersInfo.layer setBorderColor: [[UIColor darkGrayColor] CGColor]];
                    [runnersInfo.layer setBorderWidth:1.0];
                    runnersInfo.layer.cornerRadius = 2;
                    runnersInfo.clipsToBounds = YES;
                }
                
                //We've now successfully set the text
                
            });
        });
    }
}

#pragma mark - Picker View Delegate + Data Source methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     numberOfVideoLinks = [[self.run.videoLinks objectForKey:@"PickerItems"] count];
    
    if (numberOfVideoLinks == 1) {
        pickerView.hidden = YES;
        playA.enabled = NO;
        playA.tintColor = [UIColor clearColor];
        
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
            runnersInfo.frame = self.view.frame;
        } else {
            runnersInfo.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44 - 49 - 20); // In iOS 7; the navigation bar (44 points), tab bar (49 points) and status bar (20 points) are considered areas that can display content. Modifying the frame of the text view to not be blocked by any of these. 
        }
    } else if (numberOfVideoLinks > 1) {
        pickerView.hidden = NO;
        playA.enabled = YES;
        playA.tintColor = [UIColor colorWithRed:(25/255.0) green:(100/250.0) blue:(180/255.0) alpha:1];
        runnersInfo.frame = runnersInfoOriginalFrame;
    }
    
    return numberOfVideoLinks;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return [[self.run.videoLinks objectForKey:@"PickerItems"] objectAtIndex:row];
}


@end
