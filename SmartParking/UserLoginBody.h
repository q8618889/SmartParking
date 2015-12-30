//
//  UserLoginBody.h
//
//  Created by SCMac  on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserLoginBody : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *headerUri;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *passwd;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) double bodyIdentifier;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
