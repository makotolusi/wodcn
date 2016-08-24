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
#import "FSMediaPicker.h"
#import "ProfileDataManager.h"
#import "Profile.h"
#import "SkillRecordDataManager.h"
@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource, FSMediaPickerDelegate>
{
    NSMutableArray* wodTopSection;
    NSDictionary* wodTopData;
}
@end

@implementation ProfileViewController


-(void)viewDidAppear:(BOOL)animated{
    ProfileDataManager *manager=[[ProfileDataManager alloc] init];
    Profile *p=[manager queryOne];
    if (p) {
//        Profile *p=n.lastObject;
        NSLog(@"%@",p.name);
        _name.text=p.name;
        _sex.text=p.sex;
        _location.text=p.box;
        _weight.text=[NSString stringWithFormat:@"%@KG",p.weight];
        _height.text=[NSString stringWithFormat:@"%@CM",p.height];
    }
    SkillRecordDataManager *skill=[[SkillRecordDataManager alloc] init];
    SkillRecord *bp=[skill queryByNameMaxScore:@"Bench Press"];
     SkillRecord *bs=[skill queryByNameMaxScore:@"Back Squart"];
     SkillRecord *dl=[skill queryByNameMaxScore:@"Dead Lift"];
     SkillRecord *cj=[skill queryByNameMaxScore:@"Clean&Jerk"];
     SkillRecord *fs=[skill queryByNameMaxScore:@"Full Snatch"];
    //bar
    static NSNumberFormatter *barChartFormatter;
    if (!barChartFormatter){
        barChartFormatter = [[NSNumberFormatter alloc] init];
        barChartFormatter.numberStyle = NSNumberFormatterNoStyle;
        barChartFormatter.allowsFloats = NO;
        barChartFormatter.maximumFractionDigits = 0;
    }
//        self.barChart.labe= @"＊完善你的技能";
    
    self.barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(20, _headView.frame.origin.y+20, SCREEN_WIDTH-20, 200.0)];
            self.barChart.showLabel = YES;
    self.barChart.backgroundColor = [UIColor clearColor];
    self.barChart.yLabelFormatter = ^(CGFloat yValue){
        return [barChartFormatter stringFromNumber:[NSNumber numberWithFloat:yValue]];
    };
    
    //    self.barChart.labelMarginTop = 5.0;
    self.barChart.showChartBorder = YES;
    [self.barChart setXLabels:@[@"卧推",@"深蹲",@"硬拉",@"挺举",@"抓举"]];
    [self.barChart setYValues:@[bp.score==nil?@"10":bp.score,bs.score==nil?@"10":bs.score,dl.score==nil?@"10":dl.score,cj.score==nil?@"10":cj.score,fs.score==nil?@"10":fs.score]];
    [self.barChart setStrokeColors:@[PNGreen,PNGreen,PNGreen,PNGreen,PNGreen]];
    self.barChart.isGradientShow = NO;
    self.barChart.isShowNumbers = NO;
    
    [self.barChart strokeChart];
    
    self.barChart.delegate = self;
    
    [self.scrollview addSubview:self.barChart];
    [self.scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, self.barChart.frame.origin.y+ self.barChart.frame.size.height+20)];
    

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
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"编辑.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toupdate:)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    
    [self.view bringSubviewToFront:_totalScore];
//    NSArray *items = @[[PNRadarChartDataItem dataItemWithValue:3 description:@"力量"],
//                       [PNRadarChartDataItem dataItemWithValue:2 description:@"柔韧"],
//                       [PNRadarChartDataItem dataItemWithValue:8 description:@"敏捷"],
//                       [PNRadarChartDataItem dataItemWithValue:5 description:@"速度"],
//                       [PNRadarChartDataItem dataItemWithValue:4 description:@"耐力"],
//                       ];
//    PNRadarChart *radarChart = [[PNRadarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230) items:items valueDivider:1];
//    [radarChart strokeChart];
//    [self.scrollview addSubview:radarChart];
//    
       [super viewDidLoad];
    self.headView.layer.masksToBounds=YES;
    self.headView.layer.cornerRadius=50;
    _headView.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showClicked:)];
    [self.headView addGestureRecognizer:labelTapGestureRecognizer];
    
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

- (void)toupdate:(id)sender {
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    UIViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"updateProfile"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)showClicked:(id)sender
{
    FSMediaPicker *mediaPicker = [[FSMediaPicker alloc] init];
    mediaPicker.mediaType = 0;
    mediaPicker.editMode = 0;
    mediaPicker.delegate = self;
    [mediaPicker showFromView:self.view];
}

- (void)mediaPicker:(FSMediaPicker *)mediaPicker didFinishWithMediaInfo:(NSDictionary *)mediaInfo
{
//    if (mediaInfo.mediaType == FSMediaTypeVideo) {
//        self.player.contentURL = mediaInfo.mediaURL;
//        [self.player play];
//    } else {
//        [self.headView setTitle:nil ];
        if (mediaPicker.editMode == FSEditModeNone) {
            [self.headView setImage:mediaInfo.originalImage ];
        } else {
            [self.headView setImage:mediaPicker.editMode == FSEditModeCircular? mediaInfo.circularEditedImage:mediaInfo.editedImage];
        }
//    }
}

- (void)mediaPickerDidCancel:(FSMediaPicker *)mediaPicker
{
    NSLog(@"%s",__FUNCTION__);
}
@end
