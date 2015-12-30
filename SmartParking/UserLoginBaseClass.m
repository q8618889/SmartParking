//
//  UserLoginBaseClass.m
//
//  Created by SCMac  on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserLoginBaseClass.h"
#import "UserLoginBody.h"


NSString *const kUserLoginBaseClassMessage = @"message";
NSString *const kUserLoginBaseClassStatus = @"status";
NSString *const kUserLoginBaseClassBody = @"body";


@interface UserLoginBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserLoginBaseClass

@synthesize message = _message;
@synthesize status = _status;
@synthesize body = _body;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:kUserLoginBaseClassMessage fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kUserLoginBaseClassStatus fromDictionary:dict] doubleValue];
            self.body = [UserLoginBody modelObjectWithDictionary:[dict objectForKey:kUserLoginBaseClassBody]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kUserLoginBaseClassMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kUserLoginBaseClassStatus];
    [mutableDict setValue:[self.body dictionaryRepresentation] forKey:kUserLoginBaseClassBody];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.message = [aDecoder decodeObjectForKey:kUserLoginBaseClassMessage];
    self.status = [aDecoder decodeDoubleForKey:kUserLoginBaseClassStatus];
    self.body = [aDecoder decodeObjectForKey:kUserLoginBaseClassBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kUserLoginBaseClassMessage];
    [aCoder encodeDouble:_status forKey:kUserLoginBaseClassStatus];
    [aCoder encodeObject:_body forKey:kUserLoginBaseClassBody];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserLoginBaseClass *copy = [[UserLoginBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.status = self.status;
        copy.body = [self.body copyWithZone:zone];
    }
    
    return copy;
}


@end
