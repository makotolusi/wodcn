//
//  TimerViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/24.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController
- (IBAction)close:(id)sender;
- (IBAction)option:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *optionView;

@end
