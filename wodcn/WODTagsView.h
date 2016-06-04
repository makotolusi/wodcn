//
//  WODTagsView.h
//  wodcn
//
//  Created by 陆思 on 16/5/18.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WODAddViewController.h"
@protocol WODTagsViewDelegate

-(void)didSelectTag:(NSString*)text;

@end

@interface WODTagsView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tagsTable;

@property (strong,nonatomic) NSArray* tags;

@property (assign,nonatomic) id <WODTagsViewDelegate> wodTagDelegate;

@end
