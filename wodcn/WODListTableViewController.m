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
    WODDataManager *manager;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tableView.sectionFooterHeight = 0;
    wodGroup=[[NSMutableArray alloc] init];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"WODGroup" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    wods=[[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil]];
    for (NSString *groupName in wods) {
        [wodGroup addObject:groupName];
    }
    manager=[[WODDataManager alloc] init];
    NSMutableArray* datas=[manager query];
    if (datas.count!=0) {
        [wodGroup insertObject:MYWOD atIndex:0];
        [wods setValue:[manager query] forKey:MYWOD];
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
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor lightTextColor];
    }
    NSString *key=wodGroup[indexPath.section];
    if([key isEqualToString:MYWOD]){
        WOD *wod=[wods[key] objectAtIndex:indexPath.row];
        cell.textLabel.text=wod.title;
        NSString* de=wod.desc;
        de=[de stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        cell.detailTextLabel.text=de;
    }else{
        NSDictionary* dic=[wods[key] objectAtIndex:indexPath.row];
        cell.textLabel.text = dic[@"name"];
        NSString* de=dic[@"desc"];
        de=[de stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        cell.detailTextLabel.text=de;
    }
    return cell;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return wodGroup[section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = COLOR_LIGHT_BLUE;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 600, 30)];
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font=[UIFont fontWithName:@"American Typewriter" size:25];
    titleLabel.text=wodGroup[section];
    [myView addSubview:titleLabel];
    return myView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    WODDetailViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODDetail"];
    
    
    NSString *key=wodGroup[indexPath.section];
    if([key isEqualToString:MYWOD]){
        WOD *wod=[wods[key] objectAtIndex:indexPath.row];
        NSDictionary* dic=@{@"name":wod.title,@"desc":wod.desc,@"type":wod.type};
         detailViewController.wodDic=dic;
    }else{
        NSDictionary* dic=[wods[key] objectAtIndex:indexPath.row];
        detailViewController.wodDic=dic;
    }
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return YES;
    }else
        return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *key=wodGroup[indexPath.section];
        NSMutableArray* mywod= wods[key];
         WOD *wod=[mywod objectAtIndex:indexPath.row];
        [manager deleteOneByName:wod.title];
        [mywod removeObject:wod];
         [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

@end
