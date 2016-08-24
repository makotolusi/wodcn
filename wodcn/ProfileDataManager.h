//
//  ProfileDataManager.h
//  wodcn
//
//  Created by 陆思 on 16/7/7.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Profile.h"
@interface ProfileDataManager : NSObject

@property (strong,nonatomic)NSManagedObjectContext *context;

- (id)getWillInsert;

- (void)save;

- (NSArray*)query;
- (Profile*)queryOne;
@end
