//
//  AnnPoinBody.m
//
//  Created by   on 15/12/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AnnPoinBody.h"


NSString *const kAnnPoinBodyId = @"id";
NSString *const kAnnPoinBodyPortCount = @"portCount";
NSString *const kAnnPoinBodyName = @"name";
NSString *const kAnnPoinBodyCharge1 = @"charge1";
NSString *const kAnnPoinBodyPosition = @"position";
NSString *const kAnnPoinBodyCharge = @"charge";
NSString *const kAnnPoinBodyLongitude = @"longitude";
NSString *const kAnnPoinBodyLatitude = @"latitude";
NSString *const kAnnPoinBodyType = @"type";
NSString *const kAnnPoinBodyIsDeleted = @"isDeleted";
NSString *const kAnnPoinBodyMapAddr = @"mapAddr";
NSString *const kAnnPoinBodyCharge2 = @"charge2";
NSString *const kAnnPoinBodyPortLeftCount = @"portLeftCount";
NSString *const kAnnPoinBodyAlias = @"alias";
NSString *const kAnnPoinBodyDate = @"date";
NSString *const kAnnPoinBodyFloor = @"floor";
NSString *const kAnnPoinBodyChannelCount = @"channelCount";
NSString *const kAnnPoinBodyStatus = @"status";
NSString *const kAnnPoinBodyIsFree = @"isFree";


@interface AnnPoinBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AnnPoinBody

@synthesize bodyIdentifier = _bodyIdentifier;
@synthesize portCount = _portCount;
@synthesize name = _name;
@synthesize charge1 = _charge1;
@synthesize position = _position;
@synthesize charge = _charge;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize type = _type;
@synthesize isDeleted = _isDeleted;
@synthesize mapAddr = _mapAddr;
@synthesize charge2 = _charge2;
@synthesize portLeftCount = _portLeftCount;
@synthesize alias = _alias;
@synthesize date = _date;
@synthesize floor = _floor;
@synthesize channelCount = _channelCount;
@synthesize status = _status;
@synthesize isFree = _isFree;


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
            self.bodyIdentifier = [[self objectOrNilForKey:kAnnPoinBodyId fromDictionary:dict] doubleValue];
            self.portCount = [[self objectOrNilForKey:kAnnPoinBodyPortCount fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kAnnPoinBodyName fromDictionary:dict];
            self.charge1 = [[self objectOrNilForKey:kAnnPoinBodyCharge1 fromDictionary:dict] doubleValue];
            self.position = [self objectOrNilForKey:kAnnPoinBodyPosition fromDictionary:dict];
            self.charge = [[self objectOrNilForKey:kAnnPoinBodyCharge fromDictionary:dict] doubleValue];
            self.longitude = [[self objectOrNilForKey:kAnnPoinBodyLongitude fromDictionary:dict] doubleValue];
            self.latitude = [[self objectOrNilForKey:kAnnPoinBodyLatitude fromDictionary:dict] doubleValue];
            self.type = [[self objectOrNilForKey:kAnnPoinBodyType fromDictionary:dict] doubleValue];
            self.isDeleted = [[self objectOrNilForKey:kAnnPoinBodyIsDeleted fromDictionary:dict] doubleValue];
            self.mapAddr = [self objectOrNilForKey:kAnnPoinBodyMapAddr fromDictionary:dict];
            self.charge2 = [[self objectOrNilForKey:kAnnPoinBodyCharge2 fromDictionary:dict] doubleValue];
            self.portLeftCount = [[self objectOrNilForKey:kAnnPoinBodyPortLeftCount fromDictionary:dict] doubleValue];
            self.alias = [self objectOrNilForKey:kAnnPoinBodyAlias fromDictionary:dict];
            self.date = [self objectOrNilForKey:kAnnPoinBodyDate fromDictionary:dict];
            self.floor = [[self objectOrNilForKey:kAnnPoinBodyFloor fromDictionary:dict] doubleValue];
            self.channelCount = [[self objectOrNilForKey:kAnnPoinBodyChannelCount fromDictionary:dict] doubleValue];
            self.status = [[self objectOrNilForKey:kAnnPoinBodyStatus fromDictionary:dict] doubleValue];
            self.isFree = [[self objectOrNilForKey:kAnnPoinBodyIsFree fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bodyIdentifier] forKey:kAnnPoinBodyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.portCount] forKey:kAnnPoinBodyPortCount];
    [mutableDict setValue:self.name forKey:kAnnPoinBodyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.charge1] forKey:kAnnPoinBodyCharge1];
    [mutableDict setValue:self.position forKey:kAnnPoinBodyPosition];
    [mutableDict setValue:[NSNumber numberWithDouble:self.charge] forKey:kAnnPoinBodyCharge];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kAnnPoinBodyLongitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kAnnPoinBodyLatitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kAnnPoinBodyType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDeleted] forKey:kAnnPoinBodyIsDeleted];
    [mutableDict setValue:self.mapAddr forKey:kAnnPoinBodyMapAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.charge2] forKey:kAnnPoinBodyCharge2];
    [mutableDict setValue:[NSNumber numberWithDouble:self.portLeftCount] forKey:kAnnPoinBodyPortLeftCount];
    [mutableDict setValue:self.alias forKey:kAnnPoinBodyAlias];
    [mutableDict setValue:self.date forKey:kAnnPoinBodyDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.floor] forKey:kAnnPoinBodyFloor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.channelCount] forKey:kAnnPoinBodyChannelCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kAnnPoinBodyStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isFree] forKey:kAnnPoinBodyIsFree];

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

    self.bodyIdentifier = [aDecoder decodeDoubleForKey:kAnnPoinBodyId];
    self.portCount = [aDecoder decodeDoubleForKey:kAnnPoinBodyPortCount];
    self.name = [aDecoder decodeObjectForKey:kAnnPoinBodyName];
    self.charge1 = [aDecoder decodeDoubleForKey:kAnnPoinBodyCharge1];
    self.position = [aDecoder decodeObjectForKey:kAnnPoinBodyPosition];
    self.charge = [aDecoder decodeDoubleForKey:kAnnPoinBodyCharge];
    self.longitude = [aDecoder decodeDoubleForKey:kAnnPoinBodyLongitude];
    self.latitude = [aDecoder decodeDoubleForKey:kAnnPoinBodyLatitude];
    self.type = [aDecoder decodeDoubleForKey:kAnnPoinBodyType];
    self.isDeleted = [aDecoder decodeDoubleForKey:kAnnPoinBodyIsDeleted];
    self.mapAddr = [aDecoder decodeObjectForKey:kAnnPoinBodyMapAddr];
    self.charge2 = [aDecoder decodeDoubleForKey:kAnnPoinBodyCharge2];
    self.portLeftCount = [aDecoder decodeDoubleForKey:kAnnPoinBodyPortLeftCount];
    self.alias = [aDecoder decodeObjectForKey:kAnnPoinBodyAlias];
    self.date = [aDecoder decodeObjectForKey:kAnnPoinBodyDate];
    self.floor = [aDecoder decodeDoubleForKey:kAnnPoinBodyFloor];
    self.channelCount = [aDecoder decodeDoubleForKey:kAnnPoinBodyChannelCount];
    self.status = [aDecoder decodeDoubleForKey:kAnnPoinBodyStatus];
    self.isFree = [aDecoder decodeDoubleForKey:kAnnPoinBodyIsFree];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_bodyIdentifier forKey:kAnnPoinBodyId];
    [aCoder encodeDouble:_portCount forKey:kAnnPoinBodyPortCount];
    [aCoder encodeObject:_name forKey:kAnnPoinBodyName];
    [aCoder encodeDouble:_charge1 forKey:kAnnPoinBodyCharge1];
    [aCoder encodeObject:_position forKey:kAnnPoinBodyPosition];
    [aCoder encodeDouble:_charge forKey:kAnnPoinBodyCharge];
    [aCoder encodeDouble:_longitude forKey:kAnnPoinBodyLongitude];
    [aCoder encodeDouble:_latitude forKey:kAnnPoinBodyLatitude];
    [aCoder encodeDouble:_type forKey:kAnnPoinBodyType];
    [aCoder encodeDouble:_isDeleted forKey:kAnnPoinBodyIsDeleted];
    [aCoder encodeObject:_mapAddr forKey:kAnnPoinBodyMapAddr];
    [aCoder encodeDouble:_charge2 forKey:kAnnPoinBodyCharge2];
    [aCoder encodeDouble:_portLeftCount forKey:kAnnPoinBodyPortLeftCount];
    [aCoder encodeObject:_alias forKey:kAnnPoinBodyAlias];
    [aCoder encodeObject:_date forKey:kAnnPoinBodyDate];
    [aCoder encodeDouble:_floor forKey:kAnnPoinBodyFloor];
    [aCoder encodeDouble:_channelCount forKey:kAnnPoinBodyChannelCount];
    [aCoder encodeDouble:_status forKey:kAnnPoinBodyStatus];
    [aCoder encodeDouble:_isFree forKey:kAnnPoinBodyIsFree];
}

- (id)copyWithZone:(NSZone *)zone
{
    AnnPoinBody *copy = [[AnnPoinBody alloc] init];
    
    if (copy) {

        copy.bodyIdentifier = self.bodyIdentifier;
        copy.portCount = self.portCount;
        copy.name = [self.name copyWithZone:zone];
        copy.charge1 = self.charge1;
        copy.position = [self.position copyWithZone:zone];
        copy.charge = self.charge;
        copy.longitude = self.longitude;
        copy.latitude = self.latitude;
        copy.type = self.type;
        copy.isDeleted = self.isDeleted;
        copy.mapAddr = [self.mapAddr copyWithZone:zone];
        copy.charge2 = self.charge2;
        copy.portLeftCount = self.portLeftCount;
        copy.alias = [self.alias copyWithZone:zone];
        copy.date = [self.date copyWithZone:zone];
        copy.floor = self.floor;
        copy.channelCount = self.channelCount;
        copy.status = self.status;
        copy.isFree = self.isFree;
    }
    
    return copy;
}


@end
