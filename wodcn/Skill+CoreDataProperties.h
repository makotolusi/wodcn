//
//  Skill+CoreDataProperties.h
//  wodcn
//
//  Created by 陆思 on 16/6/2.
//  Copyright © 2016年 LUSI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Skill.h"

NS_ASSUME_NONNULL_BEGIN

@interface Skill (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *cn;

@end

NS_ASSUME_NONNULL_END
