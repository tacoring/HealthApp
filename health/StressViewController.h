//
//  StressViewController.h
//  health
//
//  Created by Casper on 1/7/15.
//  Copyright (c) 2015 CHHD. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface StressViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
//@interface StressViewController : UITableViewController
{
//    NSMutableArray *fileArray;
    NSArray *fileArray;
    AVAudioPlayer *_audioPlayer;
}

@property (nonatomic, retain) NSArray *fileArray;
@property (weak, nonatomic) IBOutlet UIImageView *stressImageView;


@end