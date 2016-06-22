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

- (NSMutableArray*)queryMyWOD;

- (WOD*)queryOneByName:(NSString*)name;
- (void)deleteOneByName:(NSString*)name;
-(void)update:(WOD*)wod;
- (void)deleteAll;
- (NSMutableArray*)queryAlex;
- (void)deleteAlex;
- (void)deleteExceptMyWOD;
@end
