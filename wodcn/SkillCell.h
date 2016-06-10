//
//  SkillCell.h
//  wodcn
//
//  Created by 陆思 on 16/6/9.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UILabel *unlockLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;

@end
