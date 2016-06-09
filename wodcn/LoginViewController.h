//
//  LoginViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/31.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
@interface LoginViewController : UIViewController<WXApiDelegate>
- (IBAction)nologin:(id)sender;
- (IBAction)sinaLogin:(id)sender;
- (IBAction)weixinLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImage;

@end
