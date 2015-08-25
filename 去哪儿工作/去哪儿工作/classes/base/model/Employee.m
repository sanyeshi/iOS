//
//  Employee.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Employee.h"
#import "Http.h"
@implementation Employee

- (instancetype)initWithDict:(NSDictionary *) dict
{
    self = [super init];
    if (self)
    {
        [self parseEmployeeWithDict:dict];
    }
    return self;
}

-(void) parseEmployeeWithDict:(NSDictionary *) dict
{
    if (dict==nil)
    {
        return;
    }
    self.Id=[[dict valueForKey:@"id"] unsignedIntegerValue];
    self.age=[[dict valueForKey:@"age"]unsignedIntegerValue];
    self.gender=[Employee parseGenderFromCode:[[dict valueForKey:@"sex"] unsignedIntegerValue]];
    self.email=[dict valueForKey:@"email"];
    self.grade=[dict valueForKey:@"grade"];
    self.imageUrlStr=ImageURL([dict valueForKey:@"image"]);
    self.isLocked=[[dict valueForKey:@"locked"] boolValue];
    self.isVerified=[[dict valueForKey:@"verifield"] boolValue];
    self.major=[dict valueForKey:@"mayjor"];
    self.school=[dict valueForKey:@"school"];
    self.name=[dict valueForKey:@"name"];
    self.phone=[dict valueForKey:@"phone"];
    self.password=[dict valueForKey:@"password"];
    self.rejectReason=[dict valueForKey:@"rejectReason"];
}

+(NSString *) parseGenderFromCode:(NSUInteger) code
{
    if (code==0)
    {
        return @"保密";
    }
    if (code==1)
    {
        return @"男";
    }
    if(code==2)
    {
        return @"女";
    }
    return @"保密";
}

+(NSUInteger) parseGenderToCodeFromString:(NSString *) string
{
    if([string isEqualToString:@"保密"])
    {
        return 0;
    }
    if([string isEqualToString:@"男"])
    {
        return 1;
    }
    if([string isEqualToString:@"女"])
    {
        return 2;
    }
    return 0;
}


//解档时调用
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super init];
    if (self)
    {
        _Id=[aDecoder decodeIntegerForKey:@"Id"];
        _age=[aDecoder decodeIntegerForKey:@"age"];
        _email=[aDecoder decodeObjectForKey:@"email"];
        _grade=[aDecoder decodeObjectForKey:@"grade"];
        _imageUrlStr=[aDecoder decodeObjectForKey:@"imageUrlStr"];
        _isLocked=[aDecoder decodeBoolForKey:@"isLocked"];
        _isVerified=[aDecoder decodeBoolForKey:@"isVerified"];
        _major=[aDecoder decodeObjectForKey:@"major"];
        _school=[aDecoder decodeObjectForKey:@"school"];
        _name=[aDecoder decodeObjectForKey:@"name"];
        _phone=[aDecoder decodeObjectForKey:@"phone"];
        _password=[aDecoder decodeObjectForKey:@"password"];
        _rejectReason=[aDecoder decodeObjectForKey:@"rejectReason"];
    }
    return self;
}
//归档时调用
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //将对象的数据编码
    [aCoder encodeInteger:_Id forKey:@"Id"];
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeObject:_email  forKey:@"email"];
    [aCoder encodeObject:_grade forKey:@"grade"];
    [aCoder encodeObject:_imageUrlStr forKey:@"imageUrlStr"];
    [aCoder encodeBool:_isLocked forKey:@"isLocked"];
    [aCoder encodeBool:_isVerified forKey:@"isVerified"];
    [aCoder encodeObject:_major  forKey:@"major"];
    [aCoder encodeObject:_school  forKey:@"school"];
    [aCoder encodeObject:_name  forKey:@"name"];
    [aCoder encodeObject:_phone forKey:@"phone"];
    [aCoder encodeObject:_password  forKey:@"password"];
    [aCoder encodeObject:_rejectReason  forKey:@"rejectReason"];
}

@end
