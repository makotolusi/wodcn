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
@interface SkillListController ()

@end

@implementation SkillListController
{
    NSMutableArray *skillData;
}
- (void)viewWillAppear:(BOOL)animated{
    skillData=[[NSMutableArray alloc] init];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"Skill" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    NSDictionary *wods = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    skillData=wods[@"skill"];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [skillData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"skillCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    NSDictionary* skill=[skillData objectAtIndex:indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"%@ (%@)",skill[@"name"],skill[@"cn"]];
    SkillRecordDataManager *manager=[[SkillRecordDataManager alloc] init];
    SkillRecord* data=[manager queryByNameMaxScore:skill[@"name"]];
    if (data==nil) {
        cell.detailTextLabel.text=@"";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
         cell.detailTextLabel.text=data.score.stringValue;
         cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    SkillDetailViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"SkillDetail"];
    NSDictionary* skill=[skillData objectAtIndex:indexPath.row];
    detailViewController.skillName=skill[@"name"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
