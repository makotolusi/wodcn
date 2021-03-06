//
//  SkillListController.m
//  wodcn
//
//  Created by 陆思 on 16/5/20.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "SkillListController.h"
#import "SkillDetailViewController.h"
#import "SkillRecord.h"
#import "SkillRecordDataManager.h"
#import "SkillCell.h"
#import "TableHeaderView.h"
@interface SkillListController ()

@end

@implementation SkillListController
{
//    NSMutableArray *skillData;
    NSMutableDictionary *dic;
    NSMutableArray *group;
}
- (void)viewWillAppear:(BOOL)animated{
    NSString *path= [[NSBundle mainBundle] pathForResource:@"Skill" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    dic = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    group=[[NSMutableArray alloc] init];
    for (NSString *groupName in dic) {
        [group addObject:groupName];
    }
    
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
    return group.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return [TableHeaderView drawHeaderView:group[section]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dic[group[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"skillCellIdentifier";
    SkillCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[SkillCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }else{
        cell.backgroundColor=[UIColor whiteColor];
    }
    
      NSString *key=group[indexPath.section];
    NSDictionary* skill=[dic[key] objectAtIndex:indexPath.row];
    cell.titleLabel.text =skill[@"name"];
    cell.descLabel.text=skill[@"cn"];
    SkillRecordDataManager *manager=[[SkillRecordDataManager alloc] init];
    SkillRecord* data=[manager queryByNameMaxScore:skill[@"name"]];
    if (data==nil) {
      cell.unlockLabel.hidden=NO;
        cell.scoreLabel.hidden=YES;
    }else{
        cell.unlockLabel.hidden=YES;
        if ([data.type isEqualToString:@"weight"]) {
            cell.scoreLabel.text=[NSString stringWithFormat:@"%@ kg",data.score.stringValue];
        }else
        cell.scoreLabel.text=[NSString stringWithFormat:@"%@ reps",data.score.stringValue];
        
        cell.scoreLabel.hidden=NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    SkillDetailViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"SkillDetail"];
    NSString *key=group[indexPath.section];
    NSDictionary* skill=[dic[key] objectAtIndex:indexPath.row];
    detailViewController.skillName=skill[@"name"];
       detailViewController.skillType=skill[@"type"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
