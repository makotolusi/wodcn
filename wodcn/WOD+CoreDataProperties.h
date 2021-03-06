//
//  WOD+CoreDataProperties.h
//  wodcn
//
//  Created by 陆思 on 16/5/18.
//  Copyright © 2016年 LUSI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WOD.h"

NS_ASSUME_NONNULL_BEGIN

@interface WOD (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *method;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END
