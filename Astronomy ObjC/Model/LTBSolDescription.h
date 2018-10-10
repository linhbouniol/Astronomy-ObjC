//
//  LTBSolDescription.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTBSolDescription : NSObject

@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, readonly) NSInteger totalPhotos;
@property (nonatomic, readonly) NSArray<NSString *> *cameras;

- (instancetype)initWithSol:(NSInteger)sol totalPhotos:(NSInteger)totalPhotos cameras:(NSArray<NSString *> *)cameras;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
