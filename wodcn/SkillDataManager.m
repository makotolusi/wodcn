//
//  SkillDataManager.m
//  wodcn
//
//  Created by 陆思 on 16/6/2.
//  Copyright © 2016年 LUSI. All rights reserved.
//

#import "SkillDataManager.h"
#import "AppDelegate.h"
#import "Skill.h"
@implementation SkillDataManager

@synthesize context;

//插入数据
- (void)insertBatch:(NSMutableArray*)datas;
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    for (NSDictionary* data in datas) {
        Skill *skill = [NSEntityDescription insertNewObjectForEntityForName:@"Skill"inManagedObjectContext:context];
        skill.name=data[@"name"];
        skill.cn=data[@"cn"];
        NSError *error;
        [context save:&error];
    }
}



//查询
- (NSArray*)queryLikeName:(NSString*)name
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.context = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    if(StringNotNullAndEmpty(name))
        fetchRequest.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"name like[cd] '%@*' ", name]];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Skill" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects==nil||fetchedObjects.count==0) {
        return nil;
    }
    return fetchedObjects;
}

@end
