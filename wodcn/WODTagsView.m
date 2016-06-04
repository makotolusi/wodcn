//
//  WODTagsView.m
//  wodcn
//
//  Created by 陆思 on 16/5/18.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODTagsView.h"
#import "SkillDataManager.h"
#import "Skill.h"
#import "WODAddViewController.h"
@implementation WODTagsView
{
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagsTable=[[UITableView alloc] initWithFrame:frame];
        self.tagsTable.dataSource=self;
        self.tagsTable.delegate=self;
        _tags=[[NSMutableArray alloc] init];
        [self addSubview:_tagsTable];
        SkillDataManager *skill=[[SkillDataManager alloc] init];
        _tags=[skill queryLikeName:@""];
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tags count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"wodTagsCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    Skill *skill=_tags[indexPath.row];
    cell.textLabel.text=[skill.name stringByAppendingString:[NSString stringWithFormat:@"（%@）",skill.cn]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self removeFromSuperview];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.wodTagDelegate didSelectTag:cell.textLabel.text];
}



@end
