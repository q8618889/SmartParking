//
//  AnnPoinBaseClass.m
//
//  Created by   on 15/12/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AnnPoinBaseClass.h"
#import "AnnPoinBody.h"


NSString *const kAnnPoinBaseClassMessage = @"message";
NSString *const kAnnPoinBaseClassStatus = @"status";
NSString *const kAnnPoinBaseClassBody = @"body";


@interface AnnPoinBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AnnPoinBaseClass

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
            self.message = [self objectOrNilForKey:kAnnPoinBaseClassMessage fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kAnnPoinBaseClassStatus fromDictionary:dict] doubleValue];
    NSObject *receivedAnnPoinBody = [dict objectForKey:kAnnPoinBaseClassBody];
    NSMutableArray *parsedAnnPoinBody = [NSMutableArray array];
    if ([receivedAnnPoinBody isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAnnPoinBody) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAnnPoinBody addObject:[AnnPoinBody modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAnnPoinBody isKindOfClass:[NSDictionary class]]) {
       [parsedAnnPoinBody addObject:[AnnPoinBody modelObjectWithDictionary:(NSDictionary *)receivedAnnPoinBody]];
    }

    self.body = [NSArray arrayWithArray:parsedAnnPoinBody];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kAnnPoinBaseClassMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kAnnPoinBaseClassStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBody] forKey:kAnnPoinBaseClassBody];

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

    self.message = [aDecoder decodeObjectForKey:kAnnPoinBaseClassMessage];
    self.status = [aDecoder decodeDoubleForKey:kAnnPoinBaseClassStatus];
    self.body = [aDecoder decodeObjectForKey:kAnnPoinBaseClassBody];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:kAnnPoinBaseClassMessage];
    [aCoder encodeDouble:_status forKey:kAnnPoinBaseClassStatus];
    [aCoder encodeObject:_body forKey:kAnnPoinBaseClassBody];
}

- (id)copyWithZone:(NSZone *)zone
{
    AnnPoinBaseClass *copy = [[AnnPoinBaseClass alloc] init];
    
    if (copy) {

        copy.message = [self.message copyWithZone:zone];
        copy.status = self.status;
        copy.body = [self.body copyWithZone:zone];
    }
    
    return copy;
}


@end
