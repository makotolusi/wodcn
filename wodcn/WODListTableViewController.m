//
//  WODListTableViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/3.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODListTableViewController.h"

@interface WODListTableViewController ()

@end

@implementation WODListTableViewController
{
    NSDictionary *wods;
    NSMutableArray *wodGroup;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    wodGroup=[[NSMutableArray alloc] init];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"WODGroup" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    wods = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
    for (NSString *groupName in wods) {
        [wodGroup addObject:groupName];
    }
    NSLog(@"");
    
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
    
    cell.textLabel.text = [wods[wodGroup[indexPath.section]] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=@"100 pull-ups 100 push-ups 100 push-ups 100 push-ups 100 push-ups 100 push-ups 100 ";
    return cell;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return wodGroup[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main"bundle:nil];
    UITableViewController *detailViewController=[board instantiateViewControllerWithIdentifier:@"WODDetail"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
