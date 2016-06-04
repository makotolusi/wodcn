//
//  AuthTool.m
//  wodcn
//
//  Created by 陆思 on 16/5/31.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "AuthTool.h"

@implementation AuthTool



+(BOOL)isAuthorized

{
    //取出的access_token是否存在
    
    NSString*   accessTokenStr =[[NSUserDefaults    standardUserDefaults] objectForKey:@"token"];
    
    if(StringIsNullOrEmpty(accessTokenStr))
        return NO;
    NSDate* expiresDate=[[NSUserDefaults   standardUserDefaults] objectForKey:@"expire"];
//    NSDate*   expiresDate =[NSDate dateWithTimeIntervalSinceNow:expireStr.longLongValue];
    
    //    NSLog(@"expiresDate--%@",expiresDate);
    
    NSDate*nowDate =[NSDate date];
    
    //两者的时间做比较
    
    NSComparisonResult result =[nowDate     compare:expiresDate];
    
    if(StringNotNullAndEmpty(accessTokenStr) && result==NSOrderedAscending) {
        
        return YES;
        
    }
    
    return NO;
    
}

+ (BOOL) isFirstLoad{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *lastRunVersion = [defaults objectForKey:@"lastRunKey"];
    
    
    if (!lastRunVersion) {
          [defaults setObject:currentVersion forKey:@"lastRunKey"];
        return YES;
        // App is being run for first time
    }else if (![lastRunVersion isEqualToString:currentVersion]) {
            [defaults setObject:currentVersion forKey:@"lastRunKey"];
            return YES;
            // App has been updated since last run
        }
    return NO;
}

@end
