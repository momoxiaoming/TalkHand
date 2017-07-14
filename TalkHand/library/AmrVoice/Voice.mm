//
//  Voice.m
//  TestRecord
//
//  Created by LennonChen on 16/2/26.
//  Copyright © 2016年 LennonChen. All rights reserved.
//

#import "Voice.h"
#import "VoiceConverter.h"


@implementation Voice
// 本类的单例对象
static Voice *instance = nil;

+ (Voice *)sharedInstance
{
    if (instance == nil)
    {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}



- (int)Start:(NSString *)file
{
    
    
    self.recv_path=file;
    
    
    NSURL *fileUri = [NSURL fileURLWithPath: file];
    NSError *error = nil;
    
    //设置录音参数
    _recorder = [[AVAudioRecorder alloc] initWithURL: fileUri settings: [VoiceConverter GetAudioRecorderSettingDict] error:&error];
    if (error)
    {
        NSLog(@"录音机创建失败：%@", error.localizedDescription);
        return 0;
    }
    
    error = nil;
    if ([_recorder prepareToRecord])
    {
        /* AVAudioSessionCategoryPlayAndRecord :录制和播放 AVAudioSessionCategoryAmbient :用于非以语音为主的应用,随着静音键和屏幕关闭而静音. AVAudioSessionCategorySoloAmbient :类似AVAudioSessionCategoryAmbient不同之处在于它会中止其它应用播放声音。 AVAudioSessionCategoryPlayback :用于以语音为主的应用,不会随着静音键和屏幕关闭而静音.可在后台播放声音 AVAudioSessionCategoryRecord :用于需要录音的应用,除了来电铃声,闹钟或日历提醒之外的其它系统声音都不会被播放,只提供单纯录音功能. */

        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &error];
        [[AVAudioSession sharedInstance] setActive: YES error: &error];
        if (error)
        {
            NSLog(@"录音预处理失败：%@", error.localizedDescription);
            return 0;
        }
    }
    
    _startTime=[self GetCurrentTimeForString];
    
    if ([_recorder record])
    {
        return 1;
    }
    
    return 0;
}

-(CGFloat)GetIntervalTimeForString{
    
    
    
    
    
    return _endTime-_startTime;

}


- (NSString *)Stop
{
    if (_recorder && _recorder.isRecording)
    {
        [_recorder stop];
        _recorder = nil;
    }
    
    if (_player && _player.isPlaying)
    {
        [_player stop];
        _player = nil;
    }
    
    _endTime=[self GetCurrentTimeForString];
    
    NSData *data=[NSData dataWithContentsOfFile:self.recv_path];
    
     //将文件从运行内容保存到成文件
     [data writeToFile:self.recv_path atomically:YES];
    
    
    return self.recv_path;
}

- (int)Play:(NSString *)file
{
    NSError *error = nil;
    NSURL *fileUri = [NSURL fileURLWithPath: file];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL: fileUri error:&error];
    
    
 
   
    if (error)
    {
        NSLog(@"播放机错误：%@", error.localizedDescription);
        return 0;
    }
    
    _player.numberOfLoops = 0;
    [_player prepareToPlay];
    
    if ([_player play])
    {
        return 1;
    }
    return 0;
}





- (int)IsPlaying
{
    if (_player && _player.isPlaying)
    {
        return 1;
    }
    
    return 0;
}

- (int)IsRecording
{
    if (_recorder && _recorder.isRecording)
    {
        return 1;
    }
    
    return 0;
}

- (long long)GetCurrentTimeForString
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSTimeInterval a = [date timeIntervalSince1970];
//    NSString *time = [NSString stringWithFormat: @"%f", a];
    return a;
}

- (unsigned long long)GetFileSize:(NSString *)filePath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath: filePath])
    {
        unsigned long long size = [[mgr attributesOfItemAtPath: filePath error:nil] fileSize];
        
        return size;
    }
    return -1;
}

- (int)RenameFile:(NSString *)orgFile toPath:(NSString *)dstPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath: orgFile])
    {
        if ([mgr copyItemAtPath: orgFile toPath: dstPath error: nil])
        {
            [mgr removeItemAtPath: orgFile error: nil];
            return 1;
        }
    }
    
    return 0;
}

- (int)WAV2AMR:(NSString *)wavFile amr:(NSString *)amrFile
{
    if ([VoiceConverter ConvertWavToAmr: wavFile amrSavePath: amrFile])
    {
        unsigned long long size = [self GetFileSize: amrFile];
        if (size > 0)
        {
            return 1;
        }
    }

    NSLog(@"WAV转换AMR失败！");
    return 0;
}

- (int)AMR2WAV:(NSString *)amrFile wav:(NSString *)wavFile
{
    if ([VoiceConverter ConvertAmrToWav: amrFile wavSavePath: wavFile])
    {
        unsigned long long size = [self GetFileSize: wavFile];
        if (size > 0)
        {
            return 1;
        }
    }

    NSLog(@"AMR转换WAV失败！");
    return 0;
}

@end
