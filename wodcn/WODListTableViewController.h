//
//  WODListTableViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/3.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WODListTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)categoryAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *category;
@end
