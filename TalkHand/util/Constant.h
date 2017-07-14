//
//  Header.h
//  ChatRoom
//
//  Created by 张小明 on 2017/1/21.
//  Copyright © 2017年 张小明. All rights reserved.
//

#ifndef Header_h
#define Header_h


//---------常量-------

#define MessageMaxWidth (SCREEN_WIDTH - 80*2)








#define textMsg @"0"   //文本消息
#define aduioMsg @"1"   //语音消息
#define picterMsg @"2"   //图片消息
#define videoMsg @"3"   //视频消息

#define UPloadFile @"fileUp.json"


#define getNeryInfo_URL @"stm/mainList"

#define REGIEST_URL @"register.json"

#define NEARY_Url @"stm/mainList"

#define regiest_url @"stm/register"

#define getUserinfo_url @"stm/getUserInfo"

#define getAccount_url @"stm/regist/auto"

#define wyds_url @"stm/getUserMoney"   //我要打赏

#define wyzq_url @"user/getAds"   //我要赚钱

#define adclick_url @"user/updateAdsClickState"   //我要赚钱

#define getds_url @"stm/rewardUser"   //获取打赏用户列表

#define getupdate_url @"stm/checkNewVersion"   //检查更新

#define getvideo_url @"stm/getVideoUser"   //视频匹配

#define getkf_url @"stm/getTryUser"   //今夜开房

#define getkfbm_url @"stm/applyTryUser"   //开房报名

#define upvideo_url @"stm/upLoadFile"   //上传文件

#define updateUserRes_url @"user/updateUserRes"   //上传视频和相册

#define getisVideoAttest_URL @"user/isVideoAttest" //获取视频是否认证

#define getupdateVideoAttest_URL @"user/updateVideoAttest" //视频认证

#define getfollowOther_URL @"user/followOther" //关注他人

#define updateUserInfo_URL @"user/updateUserInfo" //关注他人

#define getgz_url @"user/getFollower" //关注他人

#define getfw_url @"user/getRecentVisitor" //获取访问

#endif /* Header_h */
