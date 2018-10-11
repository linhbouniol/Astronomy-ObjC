//
//  NSURL+Secure.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "NSURL+Secure.h"

@implementation NSURL (Secure)

- (NSURL *)httpsURL
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:self resolvingAgainstBaseURL:YES];
    components.scheme = @"https";
    return components.URL;
}

@end
