//
//  PlayerViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/6/9.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()
@property (strong,nonatomic) AVPlayerViewController *moviePlayer;
@property (strong,nonatomic) AVPlayer *player;
@property (strong,nonatomic) AVPlayerItem *item;
@end

@implementation PlayerViewController
static NSString * const PlayerPreloadObserverContext = @"PlayerPreloadObserverContext";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.player=[AVPlayer playerWithURL:[NSURL URLWithString:self.url]];
//    
//    self.moviePlayer=[[AVPlayerViewController alloc]init];
//    self.moviePlayer.player=self.player;
//    
//    [self.view addSubview:self.moviePlayer.view];
//    
    
//    self.item=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.url]];
    
    NSURL *assetUrl = [NSURL URLWithString:_url];
    
    AVAsset *asset = [AVAsset assetWithURL:assetUrl];
    
    _item = [AVPlayerItem playerItemWithAsset:asset];
    
    self.player = [AVPlayer playerWithPlayerItem:_item];
    //设置AVPlayer中的AVPlayerItem
//    self.player=[AVPlayer playerWithURL:[NSURL URLWithString:self.url]];
    
    //初始化AVPlayerViewController
    self.moviePlayer=[[AVPlayerViewController alloc]init];
    
    self.moviePlayer.player=self.player;
    
    [self.view addSubview:self.moviePlayer.view];
    
    //设置AVPlayerViewController的frame
    self.moviePlayer.view.frame=self.view.frame;
    
    //监听status属性，注意监听的是AVPlayerItem
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听loadedTimeRanges属性
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    //设置监听函数，监听视频播放进度的变化，每播放一秒，回调此函数
    __weak __typeof(self) weakSelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //当前播放的时间
        NSTimeInterval current = CMTimeGetSeconds(time);
        //视频的总时间
        NSTimeInterval total = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        
        //输出当前播放的时间
        NSLog(@"now %f",current);
    }];
    
}


//AVPlayerItem监听的回调函数
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        
    }else if ([keyPath isEqualToString:@"status"]){
        if (playerItem.status == AVPlayerItemStatusReadyToPlay){
            NSLog(@"playerItem is ready");
            //如果视频准备好 就开始播放
            [self.player play];
            
        } else if(playerItem.status==AVPlayerStatusUnknown){
            NSLog(@"playerItem Unknown错误");
        }
        else if (playerItem.status==AVPlayerStatusFailed){
            NSLog(@"playerItem 失败");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
     [self.item removeObserver:self forKeyPath:@"status"];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
