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
#import "LGAlertView.h"
#import "TableHeaderView.h"
#import "Tool.h"
@interface WODListTableViewController ()<NSXMLParserDelegate,UISearchBarDelegate>

@end

@implementation WODListTableViewController
{
    NSMutableDictionary *wods;
    NSMutableArray *wodGroup;
    NSMutableDictionary *wodsBase;
    NSMutableArray *wodsTotal;
    NSMutableArray *wodGroupBase;
    NSMutableArray *category;
    WODDataManager *manager;
    int lastIndex;
}

-(void)viewWillAppear:(BOOL)animated{
    [self mywod];
    [self.tableView reloadData];
    
}

-(void)emptyData{
    wodGroup=[[NSMutableArray alloc] init];
    wods=[[NSMutableDictionary alloc] init];
    wodsBase=[NSMutableDictionary new];
    wodGroupBase=[NSMutableArray new];
}
-(void)initData{
    [self emptyData];
  
    //local
    NSString *path= [[NSBundle mainBundle] pathForResource:@"WODGirlAndHeros" ofType:@"xml"];
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLFile:path];
    NSArray* channel = [xmlDoc valueForKeyPath:@"channel"];
    for (NSDictionary *c in channel) {
        NSArray* wod=[c valueForKeyPath:@"item"];
        [wods setObject:wod forKey:c[@"title"]];
        [wodGroup addObject:c[@"title"]];
    }
    
    NSMutableArray* mywod=[self mywod];
    
    //----------alex-------
//    WODDataManager *dataManager=[[WODDataManager alloc] init];
    NSMutableArray* alexwods= [manager queryAlex];
    if (mywod.count==0) {
        [wodGroup insertObject:ALEX atIndex:0];
    }else
        [wodGroup insertObject:ALEX atIndex:1];
    
    [wods setValue:alexwods forKey:ALEX];
category=[[NSMutableArray alloc] init];
    category=[[NSMutableArray alloc] initWithArray:wodGroup];
    [category insertObject:ALL atIndex:0];

    
}

-(NSMutableArray*)mywod{
    [wodGroup removeObject:MYWOD];
    [wods removeObjectForKey:MYWOD];
    // mywod
    NSMutableArray* mywod=[manager queryMyWOD];
    if (mywod.count!=0) {
        [wodGroup insertObject:MYWOD atIndex:0];
        [wods setValue:mywod forKey:MYWOD];
    }
    return mywod;
}

-(void)alex{
    NSString* key= ALEX;
    NSArray* data= wods[ALEX];
    [self emptyData];
    [wodGroup addObject:key];
    [wods setValue:data forKey:ALEX];
}

- (void)viewDidLoad {
    [super viewDidLoad];
      manager=[[WODDataManager alloc] init];
    self.tableView.sectionFooterHeight = 0;
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [UIFont fontWithName:@"American Typewriter" size:23.0],NSFontAttributeName,
                                                                 [UIColor whiteColor]  ,NSForegroundColorAttributeName,
                                                                 nil];
    _search.delegate=self;
//    _search.showsCancelButton = YES;
      [self initData];
    wodsBase=[[NSMutableDictionary alloc] initWithDictionary:wods];
    wodGroupBase=[[NSMutableArray alloc] initWithArray:wodGroup];
    wodsTotal=[NSMutableArray new];
    for (NSString* key in wodGroupBase) {
       
        [wodsTotal addObjectsFromArray:wodsBase[key]];
    }
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
    if([key isEqualToString:Search]){
        WOD* dic=[wods[key] objectAtIndex:indexPath.row];
        cell.titleLabel.text = dic.title;
         cell.descLabel.text=[dic.desc alexWODHtmlFormat].string;
    }else
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
    [self openWod:indexPath];
}

-(void)openWod:(NSIndexPath*)indexPath{
    NSDictionary* dic=[[NSDictionary alloc] init];
    NSString *key=wodGroup[indexPath.section];
   id obj= [wods[key] objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[WOD class]]) {
        WOD *wod=obj;
        dic=@{@"title":wod.title,@"desc":wod.desc,@"type":wod.type,@"date":wod.date,@"method":wod.method==nil?@"":wod.method};
    }else
    {
        dic=obj;
//        [dic setValue:key forKey:@"type"];
    }
    
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    WODDetailViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODDetail"];
    
    detailViewController.wodDic=dic;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)openWodByObj:(id)obj{
     NSDictionary* dic=[[NSDictionary alloc] init];
    if ([obj isKindOfClass:[WOD class]]) {
        WOD *wod=obj;
        dic=@{@"title":wod.title,@"desc":wod.desc,@"type":wod.type,@"date":wod.date,@"method":wod.method==nil?@"":wod.method};
    }else
    {
        dic=obj;
//        [dic setValue:key forKey:@"type"];
    }
    
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    WODDetailViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODDetail"];
    
    detailViewController.wodDic=dic;
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
- (IBAction)categoryAction:(id)sender {
  
    LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"WOD分类来源"
                                                        message:nil
                                                          style:LGAlertViewStyleActionSheet
                                                   buttonTitles:category
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                                  actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                      NSLog(@"actionHandler, %@, %lu", title, (long unsigned)index);
                                                      
                                                      if ([title isEqualToString:ALL]) {
                                                          [self initData];
                                                      }else{
                                                      NSString* key= title;
                                                      NSArray* data= wodsBase[title];
                                                      [self emptyData];
                                                      [wodGroup addObject:key];
                                                      [wods setValue:data forKey:title];
                                                      }
//                                                      if ([title isEqualToString:MYWOD]) {
//                                                          [self mywod];
//                                                      }
//                                                      if ([title isEqualToString:ALEX]) {
//                                                         
//                                                      }
//                                                      if ([title isEqualToString:MYWOD]) {
//                                                          [self mywod];
//                                                      }
                                                       [self.tableView reloadData];
                                                  }
                              
                                                  cancelHandler:nil
                                             destructiveHandler:nil];
    [Tool configLGAlertView:alertView];
    
    [alertView showAnimated:YES completionHandler:nil];
}

- (IBAction)randomAction:(id)sender {
    int x = arc4random() % wodsTotal.count;
    id wods= wodsTotal[x];
    [self openWodByObj:wods];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{           // called when cancel button pressed
    [searchBar setShowsCancelButton:NO animated:NO];    // 取消按钮回收
    [searchBar resignFirstResponder];                                // 取消第一响应值,键盘回收,搜索结束
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
  NSMutableArray* array=  [manager queryLikeName:searchText];
//    int a=array.count;
    [self emptyData];
    [wodGroup addObject:Search];
    [wods setValue:array forKey:Search];
    [self.tableView reloadData];
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];    // 取消按钮回收
    return YES;
}
@end
