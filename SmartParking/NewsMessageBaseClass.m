//
//  NewsMessageBaseClass.m
//
//  Created by   on 15/12/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NewsMessageBaseClass.h"
#import "NewsMessageBody.h"


NSString *const kNewsMessageBaseClassMessage = @"message";
NSString *const kNewsMessageBaseClassStatus = @"status";
NSString *const kNewsMessageBaseClassBody = @"body";


@interface NewsMessageBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NewsMessageBaseClass

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
            self.message = [self objectOrNilForKey:kNewsMessageBaseClassMessage fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kNewsMessageBaseClassStatus fromDictionary:dict] doubleValue];
    NSObject *receivedNewsMessageBody = [dict objectForKey:kNewsMessageBaseClassBody];
    NSMutableArray *parsedNewsMessageBody = [NSMutableArray array];
    if ([receivedNewsMessageBody isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNewsMessageBody) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNewsMessageBody addObject:[NewsMessageBody modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNewsMessageBody isKindOfClass:[NSDictionary class]]) {
       [parsedNewsMessageBody addObject:[NewsMessageBody modelObjectWithDictionary:(NSDictionary *)receivedNewsMessageBody]];
    }

    self.body = [NSArray arrayWithArray:parsedNewsMessageBody];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kNewsMessageBaseClassMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kNewsMessageBaseClassStatus];
    NSMutableArray *tempArrayForBody = [NSMutableArray array];
    for (NSObject *subArrayObject in self.body) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBody addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBody addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBody] forKey:kNewsMessageBaseClassBody];

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

    self.message = [aDecoder decodeObjectForKey:kNewsMessageBaseClassMessage];
    self.status = [aDecoder decodeDoubleForKey:kNewsMessageBaseClassStatus];
    self.body = [aDecoder decodeObjectForKey:kNewsMessageBaseClassBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kNewsMessageBaseClassMessage];
    [aCoder encodeDouble:_status forKey:kNewsMessageBaseClassStatus];
    [aCoder encodeObject:_body forKey:kNewsMessageBaseClassBody];
}

- (id)copyWithZone:(NSZone *)zone
{
    NewsMessageBaseClass *copy = [[NewsMessageBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.status = self.status;
        copy.body = [self.body copyWithZone:zone];
    }
    
    return copy;
}


@end
