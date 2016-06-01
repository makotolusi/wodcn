//
//  LoginViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/31.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "LoginViewController.h"
#import "AuthTool.h"
#import "WeiboSDK.h"
#import "WXApi.h"
@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    if ([AuthTool isAuthorized]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)nologin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sinaLogin:(id)sender {
//    if (![AuthTool isAuthorized]) {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kRedirectURI;
        request.scope = @"all";
        request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        [WeiboSDK sendRequest:request];
//    }
}

- (IBAction)weixinLogin:(id)sender {
    
}
@end
