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
#import "WODAddViewController.h"
#import "AFNetworking.h"
#import "XMLDictionary.h"
#import "WODCell.h"
#import "NSString+Extension.h"

#import "TableHeaderView.h"
@interface WODListTableViewController ()<NSXMLParserDelegate>

@end

@implementation WODListTableViewController
{
    NSMutableDictionary *wods;
    NSMutableArray *wodGroup;
    WODDataManager *manager;
    int lastIndex;
}

-(void)viewWillAppear:(BOOL)animated{
    self.tableView.sectionFooterHeight = 0;
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObjectsAndKeys:
                        [UIFont fontWithName:@"American Typewriter" size:23.0],NSFontAttributeName,
                                                               [UIColor whiteColor]  ,NSForegroundColorAttributeName,
                                                                 nil];
    wodGroup=[[NSMutableArray alloc] init];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"WODGirlAndHeros" ofType:@"xml"];
    
   NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLFile:path];
    NSArray* channel = [xmlDoc valueForKeyPath:@"channel"];
    wods=[[NSMutableDictionary alloc] init];
 
    for (NSDictionary *c in channel) {
        [wods setObject:[c valueForKeyPath:@"item"] forKey:c[@"title"]];
        [wodGroup addObject:c[@"title"]];
    }
    manager=[[WODDataManager alloc] init];
    NSMutableArray* mywod=[manager queryMyWOD];
    if (mywod.count!=0) {
        [wodGroup insertObject:MYWOD atIndex:0];
        [wods setValue:mywod forKey:MYWOD];
    }
    //----------data-------
    WODDataManager *dataManager=[[WODDataManager alloc] init];
    NSMutableArray* alexwods= [dataManager queryAlex];
    if (mywod.count==0) {
        [wodGroup insertObject:ALEX atIndex:0];
    }else
        [wodGroup insertObject:ALEX atIndex:1];
    [wods setValue:alexwods forKey:ALEX];
    
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
    static NSString *identifier = @"WODCell";
    
    WODCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[WODCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }else{
        cell.backgroundColor=[UIColor whiteColor];
    }
    NSString *key=wodGroup[indexPath.section];
    if([key isEqualToString:MYWOD]){
        WOD *wod=[wods[key] objectAtIndex:indexPath.row];
        cell.titleLabel.text=wod.title;
        NSString* de=wod.desc;
        de=[de stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        cell.descLabel.text=de;
    }else if([key isEqualToString:ALEX]){
        WOD* dic=[wods[key] objectAtIndex:indexPath.row];
        cell.titleLabel.text = dic.title;
        cell.descLabel.text=[dic.desc alexWODHtmlFormat].string;
    }else{
        NSDictionary* dic=[wods[key] objectAtIndex:indexPath.row];
        cell.titleLabel.text = dic[@"title"];
       
         cell.descLabel.text=[[dic[@"desc"] alexWODHtmlFormat].string filterNR];
//        cell.descLabel.text=[dic[@"desc"] filterHTML];
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
    return [TableHeaderView drawHeaderView:wodGroup[section]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    WODDetailViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODDetail"];
    
    
    NSString *key=wodGroup[indexPath.section];
//    if([key isEqualToString:MYWOD]||[key isEqualToString:ALEX]){
        WOD *wod=[wods[key] objectAtIndex:indexPath.row];
        NSDictionary* dic=@{@"title":wod.title,@"desc":wod.desc,@"type":wod.type,@"date":wod.date,@"method":wod.method==nil?@"":wod.method};
         detailViewController.wodDic=dic;
//    }else
//    {
//        NSDictionary* dic=[wods[key] objectAtIndex:indexPath.row];
//         [dic setValue:key forKey:@"type"];
//        detailViewController.wodDic=dic;
//    }

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

- (IBAction)add:(id)sender {
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    WODAddViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODAdd"];
//    detailViewController.name= self.wodName.text;
//    detailViewController.desc=self.wodDesc.text;
//    detailViewController.type=self.wodType.text;
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
