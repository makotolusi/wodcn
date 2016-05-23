//
//  WODTagsView.m
//  wodcn
//
//  Created by 陆思 on 16/5/18.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODTagsView.h"

@implementation WODTagsView
{
    NSArray* tags;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagsTable=[[UITableView alloc] initWithFrame:frame];
        self.tagsTable.dataSource=self;
        self.tagsTable.delegate=self;
        tags=[NSArray arrayWithObjects:@"Push ups",@"Clean & Jerk",@"Double Under",@"Cal row", nil];
        [self addSubview:_tagsTable];
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tags count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"wodTagsCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    cell.textLabel.text=tags[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self removeFromSuperview];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.wodTagDelegate didSelectTag:cell.textLabel.text];
}

@end
