//
//  ProfileUpdateController.h
//  wodcn
//
//  Created by 陆思 on 16/7/7.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileUpdateController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UITextField *box;
@property (weak, nonatomic) IBOutlet UITextField *sex;
- (IBAction)submit:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
