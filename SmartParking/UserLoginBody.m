//
//  UserLoginBody.m
//
//  Created by SCMac  on 15/12/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserLoginBody.h"


NSString *const kUserLoginBodyUserName = @"userName";
NSString *const kUserLoginBodyNumber = @"number";
NSString *const kUserLoginBodyId = @"Id";
NSString *const kUserLoginBodyPasswd = @"passwd";


@interface UserLoginBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserLoginBody

@synthesize userName = _userName;
@synthesize number = _number;
@synthesize bodyIdentifier = _bodyIdentifier;
@synthesize passwd = _passwd;


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
            self.userName = [self objectOrNilForKey:kUserLoginBodyUserName fromDictionary:dict];
            self.number = [self objectOrNilForKey:kUserLoginBodyNumber fromDictionary:dict];
            self.bodyIdentifier = [[self objectOrNilForKey:kUserLoginBodyId fromDictionary:dict] doubleValue];
            self.passwd = [self objectOrNilForKey:kUserLoginBodyPasswd fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userName forKey:kUserLoginBodyUserName];
    [mutableDict setValue:self.number forKey:kUserLoginBodyNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bodyIdentifier] forKey:kUserLoginBodyId];
    [mutableDict setValue:self.passwd forKey:kUserLoginBodyPasswd];

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

    self.userName = [aDecoder decodeObjectForKey:kUserLoginBodyUserName];
    self.number = [aDecoder decodeObjectForKey:kUserLoginBodyNumber];
    self.bodyIdentifier = [aDecoder decodeDoubleForKey:kUserLoginBodyId];
    self.passwd = [aDecoder decodeObjectForKey:kUserLoginBodyPasswd];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userName forKey:kUserLoginBodyUserName];
    [aCoder encodeObject:_number forKey:kUserLoginBodyNumber];
    [aCoder encodeDouble:_bodyIdentifier forKey:kUserLoginBodyId];
    [aCoder encodeObject:_passwd forKey:kUserLoginBodyPasswd];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserLoginBody *copy = [[UserLoginBody alloc] init];
    
    if (copy) {

        copy.userName = [self.userName copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.bodyIdentifier = self.bodyIdentifier;
        copy.passwd = [self.passwd copyWithZone:zone];
    }
    
    return copy;
}


@end
