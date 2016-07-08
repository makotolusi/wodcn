//
//  SkillRecordDataManager.h
//  wodcn
//
//  Created by 陆思 on 16/5/27.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkillRecord.h"

@interface SkillRecordDataManager : NSObject


@property (strong,nonatomic)NSManagedObjectContext *context;

- (void)insert:(SkillRecord*)data;

- (NSMutableArray*)query:(int)pageSize andOffset:(int)currentPage;

- (SkillRecord*)queryByNameMaxScore:(NSString*)name;

- (NSMutableArray*)queryByName:(NSString*)name;

- (void)deleteOne:(SkillRecord*)data;
@end
