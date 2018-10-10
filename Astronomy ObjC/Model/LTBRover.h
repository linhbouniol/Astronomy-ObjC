//
//  LTBRover.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTBSolDescription;

NS_ASSUME_NONNULL_BEGIN

@interface LTBRover : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *launchDate;
@property (nonatomic, readonly) NSString *landingDate;
@property (nonatomic, readonly) NSString *status;
@property (nonatomic, readonly) NSInteger maxSol;
@property (nonatomic, readonly) NSString *maxDate;
@property (nonatomic, readonly) NSInteger numberOfPhotos; // total_photos
@property (nonatomic, readonly) NSArray<LTBSolDescription *> *solDescriptions; //photos

- (instancetype)initWithName:(NSString *)name
                  launchDate:(NSString *)launchDate
                 landingDate:(NSString *)landingDate
                      status:(NSString *)status
                      maxSol:(NSInteger)maxSol
                     maxDate:(NSString *)maxDate
              numberOfPhotos:(NSInteger)numberOfPhotos
             solDescriptions:(NSArray<LTBSolDescription *> *)solDescriptions;

- (instancetype)initWithDictionary:(NSDictionary *)dicitonary;

@end

NS_ASSUME_NONNULL_END
