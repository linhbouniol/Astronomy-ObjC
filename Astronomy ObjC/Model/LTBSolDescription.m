//
//  LTBSolDescription.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBSolDescription.h"

@implementation LTBSolDescription

- (instancetype)initWithSol:(NSInteger)sol totalPhotos:(NSInteger)totalPhotos cameras:(NSArray<NSString *> *)cameras
{
    if (self = [super init]) {
        _sol = sol;
        _totalPhotos = totalPhotos;
        _cameras = cameras;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger sol = [dictionary[@"sol"] integerValue];
    
    NSInteger totalPhotos = [dictionary[@"total_photos"] integerValue];
    
    NSArray<NSString *> *cameras = dictionary[@"cameras"];
    
    return [self initWithSol:sol totalPhotos:totalPhotos cameras:cameras];
}

@end
