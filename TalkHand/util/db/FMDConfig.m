//
//  FMDConfig.m
//  ChatApp
//
//  Created by 张小明 on 2017/2/6.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "FMDConfig.h"

@implementation FMDConfig


+ (FMDConfig *)sharedInstance
{
    static FMDConfig * fmdConfig;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fmdConfig=[[FMDConfig alloc]init];
    });
   
    return fmdConfig;
}

/*
 *  重写init实例方法实现。
 *
 *  @return
 *  @see [NSObject init:]
 */
- (id)init
{
    if (![super init])
        return nil;
    
    [self createTable];
    
    return self;
}
//创建数据库
-(void) createTable{
    NSString *path=[NSString stringWithFormat:@"%@/Documents/chatMSN.db",NSHomeDirectory()];// 创建数据库示例
    self.db = [FMDatabase databaseWithPath:path];
//    [self.db open];  //打开数据库
    if (![self.db open]) {
        // [db release];   // uncomment this line in manual referencing code; in ARC, this is not necessary/permitted
        self.db = nil;
        return;
    }
     //创建用户表
     NSString * sql=@"create table if not exists userinfo(_id integer primary key autoincrement,userinfo blob NOT NULL, account text NOT NULL)";
 
    
      //创建消息表
     NSString * info_sql=@"create table if not exists msgtable(msg_id integer primary key autoincrement,msg_type varchar, msg_content text ,msg_isor varchar ,msg_second varchar,msg_time varchat,otherid varchar,videoUrl varchar)";
    
     //会话列表
     NSString * msgList_sql=@"create table if not exists conversation_table(list_id integer primary key autoincrement,owerId varchar , otherId varchar,readnum varchar,list_time varchar,newmsg blob NOT NULL)";
    
    
    
     [self.db executeUpdate:sql ];
     [self.db executeUpdate:info_sql];
     [self.db executeUpdate:msgList_sql];
   
    
    
    [self.db close];
}

//获取所有的会话
-(NSMutableArray<MsgListEntity * > *)getAllConversation{
    
    NSMutableArray<MsgListEntity *> *arr=[[NSMutableArray alloc]init];
    
    
    [_db open];
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM conversation_table order by list_time desc"];
    while ([resultSet next]) {
      
        
        MsgListEntity *list_entity=[[MsgListEntity alloc]init];
        
        NSString *otherid=[resultSet stringForColumn:@"otherId"];
        NSString *list_id=[resultSet stringForColumn:@"list_id"];
        NSString *owerId=[resultSet stringForColumn:@"owerId"];
        NSString *readnum=[resultSet stringForColumn:@"readnum"];
        NSString *list_time=[resultSet stringForColumn:@"list_time"];
        NSString *newmsg=[resultSet stringForColumn:@"newmsg"];
        BaseMsg *msg=[newmsg mj_JSONObject];
//        BaseMsg *msg = [NSKeyedUnarchiver unarchiveObjectWithData:newmsg];
        
        
        list_entity.owerid=owerId;
        list_entity.otherid=otherid;
        list_entity.list_time=list_time;
        list_entity.readnum=readnum;
        list_entity.list_id=list_id;
        list_entity.list_msg=msg;
        
        [arr addObject:list_entity];
        
    }
    [resultSet close];
    [_db close];
    
    return arr;

}


//保存或者更新一个会话数据
-(void)saveAndUpdateConversation:(MsgListEntity *)dir{
    NSString * otherid=[dir valueForKey:@"otherid"];
    NSString * owerId=[dir valueForKey:@"owerid"];
    
    NSInteger readnum=[[dir valueForKey:@"readnum"] integerValue];;
    NSString * time=[dir valueForKey:@"list_time"];
    BaseMsg * msg=[dir valueForKey:@"list_msg"];
    
    NSString * msgstr=[msg mj_JSONString];
    BOOL isv=[self isConvstionWithId:otherid];
    [self.db open];
    [self.db beginTransaction];
    if(!isv){
        NSString *sql=@"insert into conversation_table(owerId,otherId,readnum,list_time,newmsg) values(?,?,?,?,?)";
        [self.db executeUpdate:sql,owerId,otherid,readnum==0?@"1":@"0",time,msgstr];
    }else{
        NSString *sql;
        if(readnum==0){
            NSInteger num=[self getReadNum:otherid]+1;
            NSLog(@"新收到的会话-%@,消息未读条数-->%lu",otherid,num);
            sql=@"update conversation_table set owerId=?,readnum=?, list_time=?,newmsg=? where otherId=?";
            
             [self.db executeUpdate:sql,owerId,[NSString stringWithFormat:@"%lu",num],time,msgstr,otherid];
        }else {
            sql=@"update conversation_table set owerId=?, list_time=?,newmsg=? where otherId=?";
             [self.db executeUpdate:sql,owerId,time,msgstr,otherid];
        }
       
    }
 
    [self.db commit];
    [self.db close];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"msg" object:self];
    

}

-(NSInteger)getReadNum:(NSString *)otherid{
   
    NSInteger readnum = 0;
    [_db open];

    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM conversation_table where otherId = ?",otherid];
    while ([resultSet next]) {
       
        NSString *num=[resultSet stringForColumn:@"readnum"] ;
        NSLog(@"新收到查询账号--%@的数据库未读消息条数%@",otherid,num);
        readnum=[num integerValue];
    }
    [resultSet close];
    [_db close];

    return readnum;
    
    
}



//清空阅读数
-(void)clearReadNum:(NSString *)userid{
    [self.db open];
    [self.db beginTransaction];
    
    NSString *sql=@"update conversation_table set readnum=? where otherId=?";
    [self.db executeUpdate:sql,0,userid];
    
    
    [self.db commit];
    [self.db close];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"msg" object:self];
}

//查询该会话是否存在吗,根据聊天的用户id查询
- (BOOL)isConvstionWithId:(NSString *)idStr
{
    [_db open];
    BOOL isExist = NO;
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM conversation_table where otherId = ?",idStr];
    while ([resultSet next]) {
        if([resultSet stringForColumn:@"otherId"]) {
            isExist = YES;
        }else{
            isExist = NO;
        }
    }
    [resultSet close];
    [_db close];
    
    return isExist;
}





-(NSDictionary *)getUserInfoWithId:(NSString *)account{
    [self.db open];
   
    NSString *sql=@"select * from userinfo where account=?";
    FMResultSet *set=[self.db executeQuery:sql,account];
    while ([set next]) {
//        dir=[[NSMutableDictionary alloc]init];
        NSString *dictData = [set stringForColumn:@"userinfo"];
        NSDictionary * dict=[Util dictionaryWithJsonString:dictData];
        return dict;
//        [dir setDictionary:dict];
    }
    [self.db close];
    [set close];  //关闭数据集
    return NULL;

}




//保存用户数据
-(void)saveUserInfo:(NSDictionary *)dir{
    BOOL isv=[self isExistWithId:dir[@"account"]];
    [self.db open];
    [self.db beginTransaction];
    
    
    if(!isv){
     
        
        
        NSString *sql=@"insert into userinfo(userinfo,account) values(?,?)";
        //注意,填充符里面的都是对象,如果数据是基本类型,要先转为对象
        [self.db executeUpdate:sql,[Util jsonStringWithObject:dir],dir[@"account"]];
        
      
    }else {
        NSString *sql=@"update userinfo set userinfo=? where account=?";
        //注意,填充符里面的都是对象,如果数据是基本类型,要先转为对象
        [self.db executeUpdate:sql,[Util jsonStringWithObject:dir],dir[@"account"]];
    }
    
    [self.db commit];
    
    [self.db close];
    
    
    
   

}

//通过一组数据的唯一标识判断数据是否存在
- (BOOL)isExistWithId:(NSString *)idStr
{
    [_db open];
    BOOL isExist = NO;
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM userinfo where account = ?",idStr];
    while ([resultSet next]) {
        if([resultSet stringForColumn:@"account"]) {
            isExist = YES;
        }else{
            isExist = NO;
        }
    }
    [resultSet close];
    [_db close];
    
    return isExist;
}



-(void)saveMessageWithOtherId:(BaseMsg *)msg{
    NSString *msg_type=[msg valueForKey:@"msg_info_type"];
    NSString *msg_content=[msg valueForKey:@"msg_content"];
    NSString *msg_second=[msg valueForKey:@"msg_second"];
    NSString *msg_isor=[msg valueForKey:@"msg_isor"];
    NSString *msg_time=[msg valueForKey:@"msg_time"];
    NSString *otherid=[msg valueForKey:@"otherid"];
    NSString *isread=[msg valueForKey:@"isread"];
     NSString *videourl=[msg valueForKey:@"videoUrl"];
       [self.db open];
       [self.db beginTransaction];
  
        NSString *sql=@"insert into msgtable(msg_type,msg_content,msg_isor,msg_second,msg_time,otherid,videoUrl) values(?,?,?,?,?,?,?)";
        //注意,填充符里面的都是对象,如果数据是基本类型,要先转为对象
        [self.db executeUpdate:sql,msg_type,msg_content,msg_isor,msg_second,msg_time,otherid,videourl];
        [self.db commit];
        [self.db close];
    
    MsgListEntity * entity=[[MsgListEntity alloc]init];
    entity.otherid=otherid;
    entity.list_msg=msg;
    entity.list_time=msg_time;
    entity.readnum=isread;
    
    [self saveAndUpdateConversation:entity];
    
}


-(NSMutableArray<BaseMsg *> *)getAllMsgWithOtherId:(NSString *)otherid{
    BaseMsg * msg;
    NSMutableArray<BaseMsg *> * arr=[[NSMutableArray alloc]init];
    [_db open];
  
    FMResultSet *resultSet= [_db executeQuery:@"SELECT * FROM msgtable where otherid = ? order by msg_time asc",otherid];
    while ([resultSet next]) {
        msg=[[BaseMsg alloc]init];
        NSString *msg_type=[resultSet stringForColumn:@"msg_type"];
         NSString *msg_isor=[resultSet stringForColumn:@"msg_isor"];
         NSString *msg_second=[resultSet stringForColumn:@"msg_second"];
         NSString *msg_time=[resultSet stringForColumn:@"msg_time"];
         NSString *otherid=[resultSet stringForColumn:@"otherid"];
         NSString *msg_content=[resultSet stringForColumn:@"msg_content"];
            NSString *video_Url=[resultSet stringForColumn:@"videoUrl"];
        msg.msg_time=msg_time;
        msg.msg_isor=msg_isor;
        msg.msg_second=msg_second;
        msg.msg_content=msg_content;
        msg.otherid=otherid;
        msg.msg_info_type=msg_type;
        msg.videoUrl=video_Url;
        
        
        [arr addObject:msg];
    }
    [resultSet close];
    [_db close];
    
    //查询所有消息后,清空会话表的未读数
    [self clearReadNum:otherid];
    
    
    return arr;
}

@end
