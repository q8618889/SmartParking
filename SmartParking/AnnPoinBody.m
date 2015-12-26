//
//  AnnPoinBody.m
//
//  Created by SCMac  on 15/12/25
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AnnPoinBody.h"


NSString *const kAnnPoinBodyFloor = @"floor";
NSString *const kAnnPoinBodyIsDeleted = @"isDeleted";
NSString *const kAnnPoinBodyPortLeftCount = @"portLeftCount";
NSString *const kAnnPoinBodyPosition = @"position";
NSString *const kAnnPoinBodyStatus = @"status";
NSString *const kAnnPoinBodyIsFree = @"isFree";
NSString *const kAnnPoinBodyDescription = @"description";
NSString *const kAnnPoinBodyLatitude = @"latitude";
NSString *const kAnnPoinBodyMapAddr = @"mapAddr";
NSString *const kAnnPoinBodyAlias = @"alias";
NSString *const kAnnPoinBodyPortCount = @"portCount";
NSString *const kAnnPoinBodyName = @"name";
NSString *const kAnnPoinBodyContact = @"contact";
NSString *const kAnnPoinBodyType = @"type";
NSString *const kAnnPoinBodyPictureUri = @"pictureUri";
NSString *const kAnnPoinBodyChannelCount = @"channelCount";
NSString *const kAnnPoinBodyId = @"id";
NSString *const kAnnPoinBodyDate = @"date";
NSString *const kAnnPoinBodyNumber = @"number";
NSString *const kAnnPoinBodyLongitude = @"longitude";
NSString *const kAnnPoinBodyCharge1 = @"charge1";
NSString *const kAnnPoinBodyCharge = @"charge";
NSString *const kAnnPoinBodyCharge2 = @"charge2";


@interface AnnPoinBody ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AnnPoinBody

@synthesize floor = _floor;
@synthesize isDeleted = _isDeleted;
@synthesize portLeftCount = _portLeftCount;
@synthesize position = _position;
@synthesize status = _status;
@synthesize isFree = _isFree;
@synthesize bodyDescription = _bodyDescription;
@synthesize latitude = _latitude;
@synthesize mapAddr = _mapAddr;
@synthesize alias = _alias;
@synthesize portCount = _portCount;
@synthesize name = _name;
@synthesize contact = _contact;
@synthesize type = _type;
@synthesize pictureUri = _pictureUri;
@synthesize channelCount = _channelCount;
@synthesize bodyIdentifier = _bodyIdentifier;
@synthesize date = _date;
@synthesize number = _number;
@synthesize longitude = _longitude;
@synthesize charge1 = _charge1;
@synthesize charge = _charge;
@synthesize charge2 = _charge2;


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
            self.floor = [[self objectOrNilForKey:kAnnPoinBodyFloor fromDictionary:dict] doubleValue];
            self.isDeleted = [[self objectOrNilForKey:kAnnPoinBodyIsDeleted fromDictionary:dict] doubleValue];
            self.portLeftCount = [[self objectOrNilForKey:kAnnPoinBodyPortLeftCount fromDictionary:dict] doubleValue];
            self.position = [self objectOrNilForKey:kAnnPoinBodyPosition fromDictionary:dict];
            self.status = [[self objectOrNilForKey:kAnnPoinBodyStatus fromDictionary:dict] doubleValue];
            self.isFree = [[self objectOrNilForKey:kAnnPoinBodyIsFree fromDictionary:dict] doubleValue];
            self.bodyDescription = [self objectOrNilForKey:kAnnPoinBodyDescription fromDictionary:dict];
            self.latitude = [[self objectOrNilForKey:kAnnPoinBodyLatitude fromDictionary:dict] doubleValue];
            self.mapAddr = [self objectOrNilForKey:kAnnPoinBodyMapAddr fromDictionary:dict];
            self.alias = [self objectOrNilForKey:kAnnPoinBodyAlias fromDictionary:dict];
            self.portCount = [[self objectOrNilForKey:kAnnPoinBodyPortCount fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kAnnPoinBodyName fromDictionary:dict];
            self.contact = [self objectOrNilForKey:kAnnPoinBodyContact fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kAnnPoinBodyType fromDictionary:dict] doubleValue];
            self.pictureUri = [self objectOrNilForKey:kAnnPoinBodyPictureUri fromDictionary:dict];
            self.channelCount = [[self objectOrNilForKey:kAnnPoinBodyChannelCount fromDictionary:dict] doubleValue];
            self.bodyIdentifier = [[self objectOrNilForKey:kAnnPoinBodyId fromDictionary:dict] doubleValue];
            self.date = [self objectOrNilForKey:kAnnPoinBodyDate fromDictionary:dict];
            self.number = [self objectOrNilForKey:kAnnPoinBodyNumber fromDictionary:dict];
            self.longitude = [[self objectOrNilForKey:kAnnPoinBodyLongitude fromDictionary:dict] doubleValue];
            self.charge1 = [[self objectOrNilForKey:kAnnPoinBodyCharge1 fromDictionary:dict] doubleValue];
            self.charge = [[self objectOrNilForKey:kAnnPoinBodyCharge fromDictionary:dict] doubleValue];
            self.charge2 = [[self objectOrNilForKey:kAnnPoinBodyCharge2 fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.floor] forKey:kAnnPoinBodyFloor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isDeleted] forKey:kAnnPoinBodyIsDeleted];
    [mutableDict setValue:[NSNumber numberWithDouble:self.portLeftCount] forKey:kAnnPoinBodyPortLeftCount];
    [mutableDict setValue:self.position forKey:kAnnPoinBodyPosition];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kAnnPoinBodyStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isFree] forKey:kAnnPoinBodyIsFree];
    [mutableDict setValue:self.bodyDescription forKey:kAnnPoinBodyDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kAnnPoinBodyLatitude];
    [mutableDict setValue:self.mapAddr forKey:kAnnPoinBodyMapAddr];
    [mutableDict setValue:self.alias forKey:kAnnPoinBodyAlias];
    [mutableDict setValue:[NSNumber numberWithDouble:self.portCount] forKey:kAnnPoinBodyPortCount];
    [mutableDict setValue:self.name forKey:kAnnPoinBodyName];
    [mutableDict setValue:self.contact forKey:kAnnPoinBodyContact];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kAnnPoinBodyType];
    [mutableDict setValue:self.pictureUri forKey:kAnnPoinBodyPictureUri];
    [mutableDict setValue:[NSNumber numberWithDouble:self.channelCount] forKey:kAnnPoinBodyChannelCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bodyIdentifier] forKey:kAnnPoinBodyId];
    [mutableDict setValue:self.date forKey:kAnnPoinBodyDate];
    [mutableDict setValue:self.number forKey:kAnnPoinBodyNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kAnnPoinBodyLongitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.charge1] forKey:kAnnPoinBodyCharge1];
    [mutableDict setValue:[NSNumber numberWithDouble:self.charge] forKey:kAnnPoinBodyCharge];
    [mutableDict setValue:[NSNumber numberWithDouble:self.charge2] forKey:kAnnPoinBodyCharge2];

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

    self.floor = [aDecoder decodeDoubleForKey:kAnnPoinBodyFloor];
    self.isDeleted = [aDecoder decodeDoubleForKey:kAnnPoinBodyIsDeleted];
    self.portLeftCount = [aDecoder decodeDoubleForKey:kAnnPoinBodyPortLeftCount];
    self.position = [aDecoder decodeObjectForKey:kAnnPoinBodyPosition];
    self.status = [aDecoder decodeDoubleForKey:kAnnPoinBodyStatus];
    self.isFree = [aDecoder decodeDoubleForKey:kAnnPoinBodyIsFree];
    self.bodyDescription = [aDecoder decodeObjectForKey:kAnnPoinBodyDescription];
    self.latitude = [aDecoder decodeDoubleForKey:kAnnPoinBodyLatitude];
    self.mapAddr = [aDecoder decodeObjectForKey:kAnnPoinBodyMapAddr];
    self.alias = [aDecoder decodeObjectForKey:kAnnPoinBodyAlias];
    self.portCount = [aDecoder decodeDoubleForKey:kAnnPoinBodyPortCount];
    self.name = [aDecoder decodeObjectForKey:kAnnPoinBodyName];
    self.contact = [aDecoder decodeObjectForKey:kAnnPoinBodyContact];
    self.type = [aDecoder decodeDoubleForKey:kAnnPoinBodyType];
    self.pictureUri = [aDecoder decodeObjectForKey:kAnnPoinBodyPictureUri];
    self.channelCount = [aDecoder decodeDoubleForKey:kAnnPoinBodyChannelCount];
    self.bodyIdentifier = [aDecoder decodeDoubleForKey:kAnnPoinBodyId];
    self.date = [aDecoder decodeObjectForKey:kAnnPoinBodyDate];
    self.number = [aDecoder decodeObjectForKey:kAnnPoinBodyNumber];
    self.longitude = [aDecoder decodeDoubleForKey:kAnnPoinBodyLongitude];
    self.charge1 = [aDecoder decodeDoubleForKey:kAnnPoinBodyCharge1];
    self.charge = [aDecoder decodeDoubleForKey:kAnnPoinBodyCharge];
    self.charge2 = [aDecoder decodeDoubleForKey:kAnnPoinBodyCharge2];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_floor forKey:kAnnPoinBodyFloor];
    [aCoder encodeDouble:_isDeleted forKey:kAnnPoinBodyIsDeleted];
    [aCoder encodeDouble:_portLeftCount forKey:kAnnPoinBodyPortLeftCount];
    [aCoder encodeObject:_position forKey:kAnnPoinBodyPosition];
    [aCoder encodeDouble:_status forKey:kAnnPoinBodyStatus];
    [aCoder encodeDouble:_isFree forKey:kAnnPoinBodyIsFree];
    [aCoder encodeObject:_bodyDescription forKey:kAnnPoinBodyDescription];
    [aCoder encodeDouble:_latitude forKey:kAnnPoinBodyLatitude];
    [aCoder encodeObject:_mapAddr forKey:kAnnPoinBodyMapAddr];
    [aCoder encodeObject:_alias forKey:kAnnPoinBodyAlias];
    [aCoder encodeDouble:_portCount forKey:kAnnPoinBodyPortCount];
    [aCoder encodeObject:_name forKey:kAnnPoinBodyName];
    [aCoder encodeObject:_contact forKey:kAnnPoinBodyContact];
    [aCoder encodeDouble:_type forKey:kAnnPoinBodyType];
    [aCoder encodeObject:_pictureUri forKey:kAnnPoinBodyPictureUri];
    [aCoder encodeDouble:_channelCount forKey:kAnnPoinBodyChannelCount];
    [aCoder encodeDouble:_bodyIdentifier forKey:kAnnPoinBodyId];
    [aCoder encodeObject:_date forKey:kAnnPoinBodyDate];
    [aCoder encodeObject:_number forKey:kAnnPoinBodyNumber];
    [aCoder encodeDouble:_longitude forKey:kAnnPoinBodyLongitude];
    [aCoder encodeDouble:_charge1 forKey:kAnnPoinBodyCharge1];
    [aCoder encodeDouble:_charge forKey:kAnnPoinBodyCharge];
    [aCoder encodeDouble:_charge2 forKey:kAnnPoinBodyCharge2];
}

- (id)copyWithZone:(NSZone *)zone
{
    AnnPoinBody *copy = [[AnnPoinBody alloc] init];
    
    if (copy) {

        copy.floor = self.floor;
        copy.isDeleted = self.isDeleted;
        copy.portLeftCount = self.portLeftCount;
        copy.position = [self.position copyWithZone:zone];
        copy.status = self.status;
        copy.isFree = self.isFree;
        copy.bodyDescription = [self.bodyDescription copyWithZone:zone];
        copy.latitude = self.latitude;
        copy.mapAddr = [self.mapAddr copyWithZone:zone];
        copy.alias = [self.alias copyWithZone:zone];
        copy.portCount = self.portCount;
        copy.name = [self.name copyWithZone:zone];
        copy.contact = [self.contact copyWithZone:zone];
        copy.type = self.type;
        copy.pictureUri = [self.pictureUri copyWithZone:zone];
        copy.channelCount = self.channelCount;
        copy.bodyIdentifier = self.bodyIdentifier;
        copy.date = [self.date copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.longitude = self.longitude;
        copy.charge1 = self.charge1;
        copy.charge = self.charge;
        copy.charge2 = self.charge2;
    }
    
    return copy;
}


@end
