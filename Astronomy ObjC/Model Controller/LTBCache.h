//
//  LTBCache.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTBCache<Key, Value> : NSObject

- (instancetype)init;

- (void)cacheWithValue:(Value)value key:(Key)key;   // generic in .h file: anything?
- (Value)valueForKey:(Key)key;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
