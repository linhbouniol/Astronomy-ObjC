//
//  LTBCamera.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTBCamera : NSObject

@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger roverId;
@property (nonatomic, readonly) NSString *fullName;

- (instancetype)initWithId:(NSInteger)identifier name:(NSString *)name roverId:(NSInteger)roverId fullName:(NSString *)fullName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
