//
//  StressViewController.m
//  health
//
//  Created by Casper on 1/7/15.
//  Copyright (c) 2015 CHHD. All rights reserved.
//

#import "StressViewController.h"
#import "AudioPlayer.h"


@interface StressViewController()

@property (strong, nonatomic) UIToolbar *toolBar;

@property (strong, nonatomic) NSArray *playItems;
@property (strong, nonatomic) NSArray *pauseItems;

@property (strong, nonatomic) UIBarButtonItem *playBBI;
@property (strong, nonatomic) UIBarButtonItem *pauseBBI;

// Add properties here
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation StressViewController {
    BOOL _isBarHide;
    BOOL _isPlaying;
}

@synthesize fileArray;
@synthesize stressImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    fileArray = [NSArray arrayWithObjects:@"General_Relaxation_Meditation", @"Public_Speaking_Meditation", @"Sleep_Meditation", @"Test_Anxiety_Meditation", nil];

    [self configureBars];
    [self configureAudioSession];
    [self configureAudioPlayer];

}
- (void)configureBars {
    
    CGRect frame = self.view.frame;
    
    // ToolBar
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 320, frame.size.width, 44)];
    [_toolBar setBarStyle:UIBarStyleBlackTranslucent];
    [_toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    self.playBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(playPause)];
    
    self.pauseBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(playPause)];
    UIBarButtonItem *leftFlexBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *rightFlexBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.playItems = [NSArray arrayWithObjects:_playBBI, nil, nil, rightFlexBBI, nil];
    self.pauseItems = [NSArray arrayWithObjects:_pauseBBI, nil, nil, rightFlexBBI, nil];
    
    [_toolBar setItems:_playItems];
    
    [self.view addSubview:_toolBar];
    _isBarHide = YES;
    _isPlaying = NO;
    
//    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandler:)];
//    [_backgroundView addGestureRecognizer:tapGR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self toggleBars];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fileArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [fileArray objectAtIndex:indexPath.row];
    
    //Create the button and add it to the cell
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button addTarget:self
//               action:@selector(customActionPressed:)
//     forControlEvents:UIControlEventTouchDown];
//    [button setTitle:@"Play" forState:UIControlStateNormal];
//    button.frame = CGRectMake(200.0f, 5.0f, 150.0f, 30.0f);
//    [cell addSubview:button];
    
    return cell;
}

-(void)customActionPressed:(NSString *)filename{
    NSLog(@"selected cell : %@", filename);
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *otherImagePath;
    UIImage *myOtherImage;
    
    NSLog(@"selected id : %@", fileArray[indexPath.row]);
//    NSString *filename = tableData[indexPath.row];
    NSString *path = [NSString stringWithFormat:@"%@/%@.mp3", [[NSBundle mainBundle]resourcePath], fileArray[indexPath.row]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
//    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
//    [_audioPlayer play];

    // pass the URL to playURL:, defined earlier in this file
    [self playURL:soundUrl];
    
    
//    otherImagePath = [myMainBundle pathForResource:@"" ofType: @"jpg"];
    otherImagePath = [NSString stringWithFormat:@"%@/%@.jpg", [[NSBundle mainBundle]resourcePath], fileArray[indexPath.row]];
    myOtherImage = [UIImage imageWithContentsOfFile:otherImagePath];
//    self.myUIImage.image = myOtherImage;
    stressImageView.image = myOtherImage;

}

- (void)toggleBars {
    CGFloat navBarDis = -44;
    CGFloat toolBarDis = 44;
    if (_isBarHide ) {
        navBarDis = -navBarDis;
        toolBarDis = -toolBarDis;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
//        CGPoint navBarCenter = _navBar.center;
//        navBarCenter.y += navBarDis;
//        [_navBar setCenter:navBarCenter];
        
        CGPoint toolBarCenter = _toolBar.center;
        toolBarCenter.y += toolBarDis;
        [_toolBar setCenter:toolBarCenter];
    }];
    
    _isBarHide = !_isBarHide;
}

- (void)tapGestureHandler:(UITapGestureRecognizer *)tapGR {
    [self toggleBars];
}

#pragma mark - Music control

- (void)playPause {
    if (_isPlaying) {
        NSLog(@"%s", __PRETTY_FUNCTION__);
        // Pause audio here
        [_audioPlayer pause];
        
        [_toolBar setItems:_playItems];  // toggle play/pause button
    }
    else {
        // Play audio here
        [_audioPlayer play];
        
        [_toolBar setItems:_pauseItems]; // toggle play/pause button
    }
    _isPlaying = !_isPlaying;
}

- (void)playURL:(NSURL *)url {
    if (_isPlaying) {
        [self playPause]; // Pause the previous audio player
    }
    
    // Add audioPlayer configurations here
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer setNumberOfLoops:-1];
    [_audioPlayer setMeteringEnabled:YES];
//    [_visualizer setAudioPlayer:_audioPlayer];
    
    [self playPause];   // Play
}

- (void)configureAudioPlayer {
    NSURL *audioFileURL = [[NSBundle mainBundle] URLForResource:@"General_Relaxation_Meditation" withExtension:@"mp3"];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileURL error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    [_audioPlayer setNumberOfLoops:0];
    [_audioPlayer setMeteringEnabled:YES];
}

- (void)configureAudioSession {
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    if (error) {
        NSLog(@"Error setting category: %@", [error description]);
    }
}

@end