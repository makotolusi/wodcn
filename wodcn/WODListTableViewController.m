//
//  WODListTableViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/3.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODListTableViewController.h"
#import "WODDataManager.h"
#import "WODDetailViewController.h"
#define MYWOD @"我的WOD"
@interface WODListTableViewController ()

@end

@implementation WODListTableViewController
{
    NSMutableDictionary *wods;
    NSMutableArray *wodGroup;
}

-(void)viewWillAppear:(BOOL)animated{
    wodGroup=[[NSMutableArray alloc] init];
    [wodGroup addObject:MYWOD];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"WODGroup" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    wods=[[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil]];
    for (NSString *groupName in wods) {
        [wodGroup addObject:groupName];
    }
    WODDataManager *manager=[[WODDataManager alloc] init];
    [wods setValue:[manager query] forKey:MYWOD];
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

    return [wodGroup count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [wods[wodGroup[section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"wodCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    NSString *key=wodGroup[indexPath.section];
    if([key isEqualToString:MYWOD]){
        WOD *wod=[wods[key] objectAtIndex:indexPath.row];
        cell.textLabel.text=wod.title;
        cell.detailTextLabel.text=wod.desc;
    }else{
        cell.textLabel.text = [wods[key] objectAtIndex:indexPath.row];
        cell.detailTextLabel.text=@"100 pull-ups 100 push-ups 100 push-ups 100 push-ups 100 push-ups 100 push-ups 100 ";
    }
    return cell;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return wodGroup[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    WODDetailViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODDetail"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
     WODDataManager *manager=[[WODDataManager alloc] init];
    detailViewController.wod=[manager getWillInsertWOD];
    [detailViewController.wod setTitle:cell.textLabel.text];
    detailViewController.wod.desc=cell.detailTextLabel.text;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
