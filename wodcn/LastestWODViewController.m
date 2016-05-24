//
//  LastestWODViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/24.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "LastestWODViewController.h"

@interface LastestWODViewController ()

@end

@implementation LastestWODViewController
{
    NSMutableArray *lastestWODScoreData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setHidden:YES];
//    self.timerView.backgroundColor=[UIColor redColor];
    
    self.lastestWODScoreList.delegate=self;
    self.lastestWODScoreList.dataSource=self;
    lastestWODScoreData=[[NSMutableArray alloc] init];
    NSString *path= [[NSBundle mainBundle] pathForResource:@"LastestWODScore" ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    lastestWODScoreData = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableLeaves error:nil];
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
    return [lastestWODScoreData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"lastestWodScoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
    }
    NSDictionary* score=[lastestWODScoreData objectAtIndex:indexPath.row];
    cell.textLabel.text = score[@"name"];
    cell.detailTextLabel.text=score[@"score"];
    return cell;
}


- (IBAction)timerMenuShow:(id)sender {
    if (self.timerView.isHidden) {
        [self setHidden:NO];
    }else
        [self setHidden:YES];
    
    
}

-(void)setHidden:(BOOL)hidden
{
    if (hidden) {
        //隐藏时
        self.timerView.alpha= 1.0f;
        [UIView beginAnimations:@"fadeOut" context:nil];
        [UIView setAnimationDuration:0.7];
        [UIView setAnimationDelegate:self];//设置委托
        [UIView setAnimationDidStopSelector:@selector(animationStop)];//当动画结束时，我们还需要再将其隐藏
        self.timerView.alpha = 0.0f;
        [UIView commitAnimations];
    }
    else
    {
        self.timerView.alpha= 0.0f;
        [self.timerView setHidden:hidden];
        [UIView beginAnimations:@"fadeIn" context:nil];
        [UIView setAnimationDuration:0.7];
        self.timerView.alpha= 1.0f;
        [UIView commitAnimations];
    }
}
-(void)animationStop
{
    [self.timerView setHidden:!self.timerView.hidden];
}

@end
