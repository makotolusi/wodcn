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
@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* wodTopSection;
    NSDictionary* wodTopData;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
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
    
    return [wodTopSection count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [wodTopData[wodTopSection[section]] count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = COLOR_LIGHT_BLUE;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH, 20)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:@"PingFang HK" size:18];
    titleLabel.text=wodTopSection[section];
    [myView addSubview:titleLabel];
    return myView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"wodTopCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    NSDictionary* obj=[wodTopData[wodTopSection[indexPath.section]] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = obj[@"name"];
    cell.detailTextLabel.text=obj[@"score"];
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
@end
