//
//  WODAddViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/12.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WODKeyBoardToolBar.h"
#import "WODTypePicker.h"
@interface WODAddViewController : UIViewController
@property (strong, nonatomic) WODTypePicker *wodType;
@property (weak, nonatomic) IBOutlet UILabel *wodTypeLabel;
@property (weak, nonatomic) IBOutlet UITextView *wodTextArea;
@end
