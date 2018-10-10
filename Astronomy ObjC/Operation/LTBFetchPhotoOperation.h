//
//  LTBFetchPhotoOperation.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTBPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface LTBFetchPhotoOperation : NSOperation

//@property (nonatomic) LTBPhoto *photo;    //private

- (instancetype)initWithPhoto:(LTBPhoto *)photo;
- (void)start;
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
