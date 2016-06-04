//
//  WODDetailViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/4.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOD.h"
@interface WODDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *wodName;
@property (weak, nonatomic) IBOutlet UITextView *wodDesc;

@property (weak, nonatomic) IBOutlet UILabel *wodType;

@property (strong, nonatomic) NSDictionary *wodDic;
@end
