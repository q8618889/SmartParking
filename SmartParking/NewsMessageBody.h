//
//  NewsMessageBody.h
//
//  Created by   on 15/12/26
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NewsMessageBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double bodyIdentifier;
@property (nonatomic, assign) double parkId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *pictureUri;
@property (nonatomic, strong) NSString *date;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
