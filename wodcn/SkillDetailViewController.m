//
//  SkillDetailViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/27.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "SkillDetailViewController.h"
#import "SkillEditeViewController.h"
#import "SkillRecordDataManager.h"
#import "SkillRecord.h"
#import "NSDate+Extension.h"
@interface SkillDetailViewController ()
{
    NSMutableArray* datas;
    
}
@end

@implementation SkillDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    SkillRecordDataManager *manager=[[SkillRecordDataManager alloc] init];
    datas=[manager queryByName:self.skillName];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = COLOR_LIGHT_BLUE;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 30)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:@"American Typewriter" size:30];
    if(datas.count!=0){
//    SkillRecord* data= datas[section];
    titleLabel.text=self.skillName;
    }
    [myView addSubview:titleLabel];
    return myView;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     if(datas.count!=0){
    SkillRecord* data= datas[section];
    return data.name;//[NSDate stringFromDate:data.date];
     }else{
         return nil;
     }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [datas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"skillDetailCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    if(datas.count!=0){
    SkillRecord* data= datas[indexPath.row];
    cell.textLabel.text = [data.date stringFromDate];
    cell.detailTextLabel.text =[NSString stringWithFormat:@"%@ kg",data.score];
    }else{
    
    }
    
    return cell;
}



- (IBAction)toEdite:(id)sender {
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    SkillEditeViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"SkillEdite"];
    detailViewController.skillName=self.skillName;
 [self.navigationController pushViewController:detailViewController animated:YES];

}
@end
