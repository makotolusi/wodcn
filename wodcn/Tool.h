//
//  Tool.h
//  wodcn
//
//  Created by 陆思 on 16/6/13.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGAlertView.h"
@interface Tool : NSObject

+ (void) sendWXImageContent:(UIView*)view;

+ (void) sendWXTextContent:(NSString*)text;

+(LGAlertView*)configLGAlertView:(LGAlertView*) alertView;
@end
