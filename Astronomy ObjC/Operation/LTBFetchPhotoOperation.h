//
//  LTBFetchPhotoOperation.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTBPhoto;

NS_ASSUME_NONNULL_BEGIN

@interface LTBFetchPhotoOperation : NSOperation

@property (nonatomic) LTBPhoto *photo;
@property (nonatomic, readonly, nullable) UIImage *image;

- (instancetype)initWithPhoto:(LTBPhoto *)photo;
//- (void)start;    // dont need to write these here, they are part of NSOperation, super class
//- (void)cancel;

@end

NS_ASSUME_NONNULL_END
