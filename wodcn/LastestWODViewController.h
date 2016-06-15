//
//  LastestWODViewController.h
//  wodcn
//
//  Created by 陆思 on 16/5/24.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "XMLDictionary.h"
@interface LastestWODViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *lastestWODScoreList;
@property (weak, nonatomic) IBOutlet UIView *timerView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (IBAction)shareWOD:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *finishLabel;
@property (weak, nonatomic) IBOutlet UITextView *wodDesc;
@property (weak, nonatomic) IBOutlet UILabel *wodDate;
@property (weak, nonatomic) IBOutlet UILabel *wodSource;
@property (weak, nonatomic) IBOutlet UIStackView *contentView;
- (IBAction)shareAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)timerMenuShow:(id)sender;
@end
