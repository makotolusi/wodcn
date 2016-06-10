//
//  SkillCell.m
//  wodcn
//
//  Created by 陆思 on 16/6/9.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "SkillCell.h"

@implementation SkillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _unlockLabel.layer.borderWidth=1;
    _unlockLabel.layer.borderColor=[[UIColor redColor] CGColor];
    _unlockLabel.layer.cornerRadius=3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
