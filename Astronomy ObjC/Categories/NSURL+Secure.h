//
//  NSURL+Secure.h
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (Secure)

@property (nonatomic, readonly) NSURL *httpsURL;

@end

NS_ASSUME_NONNULL_END
