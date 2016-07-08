//
//  SkillEditeViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/27.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillEditeViewController : UIViewController
- (IBAction)add:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UITextField *score;

@property (weak, nonatomic) IBOutlet UITextView *desc;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextField *repsL;

@property (strong, nonatomic) NSString *skillName;
@property (strong, nonatomic) NSString *skillType;
@property (weak, nonatomic) IBOutlet UIStackView *wsv;
@property (weak, nonatomic) IBOutlet UIStackView *rsv;
@property (weak, nonatomic) IBOutlet UILabel *dateL;

@end
