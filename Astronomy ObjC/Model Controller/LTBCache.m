//
//  LTBCache.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBCache.h"

@interface LTBCache<Key, Value> ()

@property (nonatomic, copy, readwrite) NSMutableDictionary<Key, Value> *internalCache;
@property dispatch_queue_t queue;

@end

@implementation LTBCache

- (instancetype)init {
    if (self = [super init]) {
        _queue = dispatch_queue_create("com.LinhBouniol.Astronomy-ObjC.CacheQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)cacheWithValue:(id)value key:(id)key    // generic in .m file: id
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.internalCache[key] = value;
    });
}

- (id)valueForKey:(id)key
{
    __block id result = nil;
    dispatch_sync(self.queue, ^{
        result = self.internalCache[key];
    });
    return result;
}

- (void)clear
{
    dispatch_async(self.queue, ^{
        [self.internalCache removeAllObjects];
    });
}

@end
