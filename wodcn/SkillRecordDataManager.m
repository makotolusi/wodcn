//
//  SkillRecordDataManager.m
//  wodcn
//
//  Created by 陆思 on 16/5/27.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "SkillRecordDataManager.h"
#import "AppDelegate.h"
#import "SkillRecord.h"
@implementation SkillRecordDataManager
{
}
@synthesize context;

//插入数据
- (void)insert:(SkillRecord*)data
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    SkillRecord *skillRecord = [NSEntityDescription insertNewObjectForEntityForName:@"SkillRecord"inManagedObjectContext:context];
    skillRecord.name=data.name;
    skillRecord.desc=data.desc;
    skillRecord.type=data.type;
    skillRecord.date=data.date;
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"不能保存：%@",[error localizedDescription]);
    }
}

//查询
- (NSMutableArray*)query:(int)pageSize andOffset:(int)currentPage
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setFetchLimit:pageSize];
    [fetchRequest setFetchOffset:currentPage];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SkillRecord" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];

    for (SkillRecord *info in fetchedObjects) {
        [resultArray addObject:info];
    }
    return resultArray;
}

//查询
- (SkillRecord*)queryByNameMaxScore:(NSString*)name
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name = '%@' ", name]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SkillRecord" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects==nil||fetchedObjects.count==0) {
        return nil;
    }
    return fetchedObjects[0];
}


//查询
- (NSMutableArray*)queryByName:(NSString*)name
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name = '%@' ", name]];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SkillRecord" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (SkillRecord *info in fetchedObjects) {
        [resultArray addObject:info];
    }
    return resultArray;
}

@end
