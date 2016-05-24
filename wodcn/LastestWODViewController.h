//
//  LastestWODViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/24.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastestWODViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *lastestWODScoreList;

@end
