//
//  Resume.m
//  parttime
//
//  Created by 孙硕磊 on 5/11/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Resume.h"
#import "Employee.h"
#import "Experience.h"
#import "Http.h"

@implementation Resume

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        [self parseJobWithDict:dict];
    }
    return self;
}

-(void) parseJobWithDict:(NSDictionary *) dict
{
    if (dict)
    {
        self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
        self.employee=[[Employee alloc] initWithDict:[dict valueForKey:@"employee"]];
        self.evaluation=[dict valueForKey:@"evaluation"];
        self.campusExperiences=[self parseExperiencesWithString:[dict valueForKey:@"campusExperiment"]];
        self.educationExperiences=[self parseExperiencesWithString:[dict valueForKey:@"educationExperiment"]];
        self.practiceExperiences=[self parseExperiencesWithString:[dict valueForKey:@"practiceExperiment"]];
        self.tags=[[dict valueForKey:@"tags"] componentsSeparatedByString:@";"];
        NSArray * array=[[dict valueForKey:@"personShow"] componentsSeparatedByString:@";"];
        NSMutableArray * arrayM=[[NSMutableArray alloc] initWithCapacity:array.count];
        for (NSString * str in array)
        {
            [arrayM addObject:ImageURL(str)];
        }
        self.imageUrlStrs=[arrayM copy];
    }
}

-(NSArray * ) parseExperiencesWithString:(NSString *) string
{
    if (string==nil)
    {
        return nil;
    }
    NSArray * array=[NSJSONSerialization JSONObjectWithData: [string dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    NSMutableArray * experiences=[[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary * dict in array)
    {
        Experience * experience=[[Experience alloc] initWithDict:dict];
        [experiences addObject:experience];
    }
    return experiences;
}

@end
