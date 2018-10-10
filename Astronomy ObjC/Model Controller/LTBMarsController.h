//
//  LTBMarsController.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTBRover, LTBPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface LTBMarsController : NSObject

- (void)fetchRoverWithName:(NSString *)name completion:(void (^)(LTBRover * _Nullable rover, NSError * _Nullable error))completion;

- (void)fetchPhotosFromRover:(LTBRover *)rover onSol:(NSInteger)sol completion:(void (^)(NSArray<LTBPhoto *> * _Nullable photos, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
