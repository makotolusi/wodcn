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

-(void)viewDidLoad{

//    UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cfpic2.jpg"]];
//    customBackground.contentMode=UIViewContentModeScaleAspectFit;
//    [self.view addSubview:customBackground];
    [self.view sendSubviewToBack:_backgroudImage];
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
    [self sendWXAuthRequest];
}

-(void)sendWXAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ] ;
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

@end
