//
//  WODKeyBoardToolBar.h
//  wodcn
//
//  Created by 陆思 on 16/5/13.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WODKeyBoardToolBarDelegate

-(void)off;

@end


@interface WODKeyBoardToolBar : UIToolbar

@property (assign,nonatomic) id <WODKeyBoardToolBarDelegate> wodToolbarDelegate;

@end
