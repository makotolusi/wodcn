//
//  SkillDataManager.h
//  wodcn
//
//  Created by 陆思 on 16/6/2.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SkillDataManager : NSObject


@property (strong,nonatomic)NSManagedObjectContext *context;

- (void)insertBatch:(NSMutableArray*)datas;

- (NSArray*)queryLikeName:(NSString*)name;

@end
