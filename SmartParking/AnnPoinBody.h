//
//  AnnPoinBody.h
//
//  Created by   on 15/12/9
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AnnPoinBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double bodyIdentifier;
@property (nonatomic, assign) double portCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double charge1;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, assign) double charge;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double isDeleted;
@property (nonatomic, strong) NSString *mapAddr;
@property (nonatomic, assign) double charge2;
@property (nonatomic, assign) double portLeftCount;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) double floor;
@property (nonatomic, assign) double channelCount;
@property (nonatomic, assign) double status;
@property (nonatomic, assign) double isFree;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
