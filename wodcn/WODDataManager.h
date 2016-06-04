//
//  WODDataManager.h
//  wodcn
//
//  Created by 陆思 on 16/5/30.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WOD.h"
@interface WODDataManager : NSObject


@property (strong,nonatomic)NSManagedObjectContext *context;

- (WOD*)getWillInsertWOD;
//插入数据
- (void)insert:(NSDictionary*)data;

- (NSMutableArray*)query;

- (void)deleteOneByName:(NSString*)name;

@end
