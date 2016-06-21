//
//  InitData.m
//  wodcn
//
//  Created by 陆思 on 16/6/16.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "InitData.h"
#import "AFNetworking.h"
#import "XMLDictionary.h"
#import "CoreDataManager.h"
#import "WODDataManager.h"
#import "NSDate+Extension.h"
#import "NSString+Extension.h"
#import "LBProgressHUD.h"
@implementation InitData


+(void)initData:(UIView*)view{
    [LBProgressHUD showHUDto:view animated:YES];
    WODDataManager *dataManager=[[WODDataManager alloc] init];
    [dataManager deleteAlex];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/rss+xml",nil];//application/rss+xml
    [manager GET:@"http://www.alexandriacrossfit.com/feed/" parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSXMLParser *parser = (NSXMLParser *)responseObject;
        NSDictionary *dic = [NSDictionary dictionaryWithXMLParser:parser];
        NSDictionary *channel=dic[@"channel"];
        NSString* wodSource=channel[@"title"];
        NSArray* item=channel[@"item"];
        for (NSDictionary* totdayWod in item) {
            NSString* wodTitle=totdayWod[@"title"];
            NSString* wodDate=totdayWod[@"pubDate"];
            NSString* link=totdayWod[@"link"];
            manager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
            manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",nil];//application/rss+xml
            [manager GET:link parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
                NSString* searchText=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                NSDate * date=[wodDate dateFromString:ALEX_DATE_FORMAT];
                NSDictionary *wod=@{@"title":wodTitle,@"type":@"alex",@"desc":[searchText fetchWODText],@"date":date};
                [dataManager insert:wod];
                [LBProgressHUD hideAllHUDsForView:view animated:YES];
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"reloadLastedWOD" object:nil userInfo:@{@"1":@"123"}];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
            } failure:^(AFHTTPRequestOperation *operation,NSError *error){
                [LBProgressHUD hideAllHUDsForView:view animated:YES];
                NSLog(@"error = %@",error);
                
            }];
            
        }
       
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        NSLog(@"error = %@",error);
        
    }];
}
@end
