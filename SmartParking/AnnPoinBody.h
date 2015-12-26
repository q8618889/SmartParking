//
//  AnnPoinBody.h
//
//  Created by   on 15/12/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AnnPoinBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double floor;
@property (nonatomic, assign) double isDeleted;
@property (nonatomic, assign) double portLeftCount;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double isFree;
@property (nonatomic, assign) double charge2;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) NSString *mapAddr;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, assign) double portCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *pictureUri;
@property (nonatomic, assign) double channelCount;
@property (nonatomic, assign) double bodyIdentifier;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double charge1;
@property (nonatomic, assign) double charge;
@property (nonatomic, strong) NSString *bodyDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
