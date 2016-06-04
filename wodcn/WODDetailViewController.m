//
//  WODDetailViewController.m
//  wodcn
//
//  Created by 陆思 on 16/5/4.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODDetailViewController.h"

@interface WODDetailViewController ()

@end

@implementation WODDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wodName.text=_wodDic[@"name"];
    self.wodType.backgroundColor=COLOR_LIGHT_BLUE;
    if (StringIsNullOrEmpty(_wodDic[@"type"])) {
        self.wodType.text=@"For Time";
    }else
        self.wodType.text=[NSString stringWithFormat:@"%@:",_wodDic[@"type"]];
    
    self.wodDesc.text=_wodDic[@"desc"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
