//
//  TableHeaderView.m
//  wodcn
//
//  Created by 陆思 on 16/6/10.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "TableHeaderView.h"

@implementation TableHeaderView

+(UIView*)drawHeaderView:(NSString*)title {
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = COLOR_LIGHT_BLUE;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH, 20)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:@"American Typewriter" size:18];
    titleLabel.text=title;
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0, 0.7);
    [myView addSubview:titleLabel];
    return myView;
}


@end
