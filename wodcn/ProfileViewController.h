//
//  ProfileViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/20.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "PNChart.h"
@interface ProfileViewController : UIViewController<WBHttpRequestDelegate,PNChartDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UITableView *wodTopList;
@property (weak, nonatomic) IBOutlet UILabel *name;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *logoutbtn;
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UINavigationBar *logoutBar;
@property (weak, nonatomic) IBOutlet UILabel *totalScore;

@property (nonatomic) PNBarChart * barChart;

- (void)reloadData;

@end
