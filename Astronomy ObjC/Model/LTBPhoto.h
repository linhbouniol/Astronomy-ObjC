//
//  LTBPhoto.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTBCamera;

NS_ASSUME_NONNULL_BEGIN

@interface LTBPhoto : NSObject

@property (nonatomic, readonly) NSInteger photoId;
@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, readonly) LTBCamera *camera;
@property (nonatomic, readonly) NSString *earthDate;
@property (nonatomic, readonly) NSURL *imageURL;

- (instancetype)initWithPhotoId:(NSInteger)photoId sol:(NSInteger)sol camera:(LTBCamera *)camera earthDate:(NSString *)earthDate imageURL:(NSURL *)imageURL;
- (instancetype)initWithDictionary:(NSDictionary *)dicitonary;


@end

NS_ASSUME_NONNULL_END
