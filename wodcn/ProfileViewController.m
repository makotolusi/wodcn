//
//  ProfileViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/20.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "ProfileViewController.h"

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

@end
