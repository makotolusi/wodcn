//
//  ProfileViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/20.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "ProfileViewController.h"
#import "AuthTool.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "TableHeaderView.h"
#import "PNChart.h"
#import "Tool.h"
@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* wodTopSection;
    NSDictionary* wodTopData;
}
@end

@implementation ProfileViewController


-(void)viewDidAppear:(BOOL)animated{
    
//
   
}
/**
 Endurance 心血管和呼吸系统耐力
 Agility 灵活
 Balance 平衡
 Speed 速度
 Power 力量
 Accuracy 精准
 Stamina 耐力
 Coordination 协调
 Flexibility柔韧
 Strength 强度
 **/
- (void)viewDidLoad {
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
    
    [self.view bringSubviewToFront:_totalScore];
    NSArray *items = @[[PNRadarChartDataItem dataItemWithValue:3 description:@"力量"],
                       [PNRadarChartDataItem dataItemWithValue:2 description:@"柔韧"],
                       [PNRadarChartDataItem dataItemWithValue:8 description:@"敏捷"],
                       [PNRadarChartDataItem dataItemWithValue:5 description:@"速度"],
                       [PNRadarChartDataItem dataItemWithValue:4 description:@"耐力"],
                       ];
    PNRadarChart *radarChart = [[PNRadarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230) items:items valueDivider:1];
    [radarChart strokeChart];
    [self.scrollview addSubview:radarChart];
    
    //bar
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        barChartFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
//    self.barChart. = @"Bar Chart";
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, 210, SCREEN_WIDTH-20, 200.0)];
    //        self.barChart.showLabel = NO;
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
    };
    
    
//    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    [self.barChart setXLabels:@[@"卧推",@"深蹲",@"硬拉",@"挺举",@"抓举"]];
    [self.barChart setYValues:@[@100.82,@10.88,@60.96,@130.93,@50.93]];
    [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNRed,PNGreen,PNGreen]];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = NO;
    
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    
    [self.scrollview addSubview:self.barChart];
    [self.scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, self.barChart.frame.origin.y+ self.barChart.frame.size.height+20)];
    
    [super viewDidLoad];
    self.headView.layer.masksToBounds=YES;
    self.headView.layer.cornerRadius=50;
  
    self.wodTopList.delegate=self;
    self.wodTopList.dataSource=self;
    wodTopSection=[[NSMutableArray alloc] init];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"WODTop" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    wodTopData = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    for (NSString *groupName in wodTopData) {
        [wodTopSection addObject:groupName];
    }
    
    [self reloadData];
    
  
}

- (void)reloadData {
    if ([AuthTool isAuthorized]) {
        NSString* url= [[NSUserDefaults   standardUserDefaults] objectForKey:kUserLogo];
        NSString* name= [[NSUserDefaults   standardUserDefaults] objectForKey:kUserName];
        UIImage * result = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        [  self.headView setImage:result];
        self.name.text=name;
        [self.loginbtn setHidden:YES];
        [self.logoutbtn setHidden:NO];
    }else{
        [self.logoutbtn setHidden:YES];
        [self.loginbtn setHidden:NO];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [wodTopData[wodTopSection[section]] count];
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [TableHeaderView drawHeaderView:wodTopSection[section]];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"wodTopCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    NSDictionary* obj=[wodTopData[wodTopSection[indexPath.section]] objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = obj[@"name"];
//    cell.detailTextLabel.text=obj[@"score"];
    return cell;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return wodTopSection[section];
}

- (IBAction)logout:(id)sender {
    [self showOkayCancelAlert];

}

- (void)showOkayCancelAlert {
    NSString *title = NSLocalizedString(@"是否退出登录", nil);
//    NSString *message = NSLocalizedString(@"A message should be a short, complete sentence.", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
       
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");//
        NSString *token=[[NSUserDefaults standardUserDefaults] valueForKey:kWBToken];
        [WeiboSDK logOutWithToken:token delegate:self withTag:@"user1"];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        self.name.text=@"点击头像登录";
        self.headView.image=[UIImage imageNamed:@"defaulthead.jpg"];
        self.loginbtn.hidden=NO;
        self.logoutbtn.hidden=YES;
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)share:(id)sender {
        [Tool sendWXImageContent:self.view];
    
}
@end
