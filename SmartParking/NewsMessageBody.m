//
//  NewsMessageBody.m
//
//  Created by   on 15/12/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NewsMessageBody.h"


NSString *const kNewsMessageBodyId = @"id";
NSString *const kNewsMessageBodyParkId = @"parkId";
NSString *const kNewsMessageBodyContent = @"content";
NSString *const kNewsMessageBodyHeader = @"header";
NSString *const kNewsMessageBodyPictureUri = @"pictureUri";
NSString *const kNewsMessageBodyDate = @"date";


@interface NewsMessageBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewsMessageBody

@synthesize bodyIdentifier = _bodyIdentifier;
@synthesize parkId = _parkId;
@synthesize content = _content;
@synthesize header = _header;
@synthesize pictureUri = _pictureUri;
@synthesize date = _date;


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
            self.bodyIdentifier = [[self objectOrNilForKey:kNewsMessageBodyId fromDictionary:dict] doubleValue];
            self.parkId = [[self objectOrNilForKey:kNewsMessageBodyParkId fromDictionary:dict] doubleValue];
            self.content = [self objectOrNilForKey:kNewsMessageBodyContent fromDictionary:dict];
            self.header = [self objectOrNilForKey:kNewsMessageBodyHeader fromDictionary:dict];
            self.pictureUri = [self objectOrNilForKey:kNewsMessageBodyPictureUri fromDictionary:dict];
            self.date = [self objectOrNilForKey:kNewsMessageBodyDate fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bodyIdentifier] forKey:kNewsMessageBodyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.parkId] forKey:kNewsMessageBodyParkId];
    [mutableDict setValue:self.content forKey:kNewsMessageBodyContent];
    [mutableDict setValue:self.header forKey:kNewsMessageBodyHeader];
    [mutableDict setValue:self.pictureUri forKey:kNewsMessageBodyPictureUri];
    [mutableDict setValue:self.date forKey:kNewsMessageBodyDate];

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

    self.bodyIdentifier = [aDecoder decodeDoubleForKey:kNewsMessageBodyId];
    self.parkId = [aDecoder decodeDoubleForKey:kNewsMessageBodyParkId];
    self.content = [aDecoder decodeObjectForKey:kNewsMessageBodyContent];
    self.header = [aDecoder decodeObjectForKey:kNewsMessageBodyHeader];
    self.pictureUri = [aDecoder decodeObjectForKey:kNewsMessageBodyPictureUri];
    self.date = [aDecoder decodeObjectForKey:kNewsMessageBodyDate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_bodyIdentifier forKey:kNewsMessageBodyId];
    [aCoder encodeDouble:_parkId forKey:kNewsMessageBodyParkId];
    [aCoder encodeObject:_content forKey:kNewsMessageBodyContent];
    [aCoder encodeObject:_header forKey:kNewsMessageBodyHeader];
    [aCoder encodeObject:_pictureUri forKey:kNewsMessageBodyPictureUri];
    [aCoder encodeObject:_date forKey:kNewsMessageBodyDate];
}

- (id)copyWithZone:(NSZone *)zone
{
    NewsMessageBody *copy = [[NewsMessageBody alloc] init];
    
    if (copy) {

        copy.bodyIdentifier = self.bodyIdentifier;
        copy.parkId = self.parkId;
        copy.content = [self.content copyWithZone:zone];
        copy.header = [self.header copyWithZone:zone];
        copy.pictureUri = [self.pictureUri copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
    }
    
    return copy;
}


@end
