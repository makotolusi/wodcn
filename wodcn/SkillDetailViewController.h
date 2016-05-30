//
//  SkillDetailViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/27.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillDetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

- (NSMutableArray*)queryByName:(NSString*)name;

- (IBAction)toEdite:(id)sender;

@property (strong, nonatomic) NSString *skillName;

@end
