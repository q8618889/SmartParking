//
//  UserLoginBody.m
//
//  Created by SCMac  on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserLoginBody.h"


NSString *const kUserLoginBodyHeaderUri = @"headerUri";
NSString *const kUserLoginBodyNumber = @"number";
NSString *const kUserLoginBodyPasswd = @"passwd";
NSString *const kUserLoginBodyNickname = @"nickname";
NSString *const kUserLoginBodyId = @"Id";
NSString *const kUserLoginBodyUserName = @"userName";


@interface UserLoginBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserLoginBody

@synthesize headerUri = _headerUri;
@synthesize number = _number;
@synthesize passwd = _passwd;
@synthesize nickname = _nickname;
@synthesize bodyIdentifier = _bodyIdentifier;
@synthesize userName = _userName;


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
            self.headerUri = [self objectOrNilForKey:kUserLoginBodyHeaderUri fromDictionary:dict];
            self.number = [self objectOrNilForKey:kUserLoginBodyNumber fromDictionary:dict];
            self.passwd = [self objectOrNilForKey:kUserLoginBodyPasswd fromDictionary:dict];
            self.nickname = [self objectOrNilForKey:kUserLoginBodyNickname fromDictionary:dict];
            self.bodyIdentifier = [[self objectOrNilForKey:kUserLoginBodyId fromDictionary:dict] doubleValue];
            self.userName = [self objectOrNilForKey:kUserLoginBodyUserName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headerUri forKey:kUserLoginBodyHeaderUri];
    [mutableDict setValue:self.number forKey:kUserLoginBodyNumber];
    [mutableDict setValue:self.passwd forKey:kUserLoginBodyPasswd];
    [mutableDict setValue:self.nickname forKey:kUserLoginBodyNickname];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bodyIdentifier] forKey:kUserLoginBodyId];
    [mutableDict setValue:self.userName forKey:kUserLoginBodyUserName];

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

    self.headerUri = [aDecoder decodeObjectForKey:kUserLoginBodyHeaderUri];
    self.number = [aDecoder decodeObjectForKey:kUserLoginBodyNumber];
    self.passwd = [aDecoder decodeObjectForKey:kUserLoginBodyPasswd];
    self.nickname = [aDecoder decodeObjectForKey:kUserLoginBodyNickname];
    self.bodyIdentifier = [aDecoder decodeDoubleForKey:kUserLoginBodyId];
    self.userName = [aDecoder decodeObjectForKey:kUserLoginBodyUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_headerUri forKey:kUserLoginBodyHeaderUri];
    [aCoder encodeObject:_number forKey:kUserLoginBodyNumber];
    [aCoder encodeObject:_passwd forKey:kUserLoginBodyPasswd];
    [aCoder encodeObject:_nickname forKey:kUserLoginBodyNickname];
    [aCoder encodeDouble:_bodyIdentifier forKey:kUserLoginBodyId];
    [aCoder encodeObject:_userName forKey:kUserLoginBodyUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserLoginBody *copy = [[UserLoginBody alloc] init];
    
    if (copy) {

        copy.headerUri = [self.headerUri copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.passwd = [self.passwd copyWithZone:zone];
        copy.nickname = [self.nickname copyWithZone:zone];
        copy.bodyIdentifier = self.bodyIdentifier;
        copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}


@end
