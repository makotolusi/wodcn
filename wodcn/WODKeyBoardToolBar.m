//
//  WODKeyBoardToolBar.m
//  wodcn
//
//  Created by 陆思 on 16/5/13.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "WODKeyBoardToolBar.h"

@implementation WODKeyBoardToolBar


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //设置style
    [self setBarStyle:UIBarStyleBlackTranslucent];
    
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone  target:self action:@selector(resignKeyboard)];
    
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [self setItems:buttonsArray];
    

}
//隐藏键盘
- (void)resignKeyboard {
    [self.wodToolbarDelegate off];
}

 
@end
