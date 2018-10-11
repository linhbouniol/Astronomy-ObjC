//
//  LTBFetchPhotoOperation.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBFetchPhotoOperation.h"
#import "LTBPhoto.h"
#import "NSURL+Secure.h"

@interface LTBFetchPhotoOperation ()

@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic, readwrite) UIImage *image;

// NSOperation States
@property (nonatomic, readwrite, getter=isReady) BOOL ready;
@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;

@end

@implementation LTBFetchPhotoOperation

@synthesize ready = _ready, executing = _executing, finished = _finished;

//- (void)setReady:(BOOL)ready
//{
//    if (_ready != ready)
//    {
//        [self willChangeValueForKey:NSStringFromSelector(@selector(isReady))];
//        _ready = ready;
//        [self didChangeValueForKey:NSStringFromSelector(@selector(isReady))];
//    }
//}
//
//- (void)setExecuting:(BOOL)executing
//{
//    if (_executing != executing)
//    {
//        [self willChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
//        _executing = executing;
//        [self didChangeValueForKey:NSStringFromSelector(@selector(isExecuting))];
//    }
//}
//
//- (void)setFinished:(BOOL)finished
//{
//    if (_finished != finished)
//    {
//        [self willChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
//        _finished = finished;
//        [self didChangeValueForKey:NSStringFromSelector(@selector(isFinished))];
//    }
//}

/*
 NSOperation blocks KVO notifications for the state keys, so we override it to allow them.
 Or implement them ourselves above.
 */

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    if ([key isEqualToString:@"ready"] || [key isEqualToString:@"executing"] || [key isEqualToString:@"finished"]) {
        return YES;
    }
    
    return [super automaticallyNotifiesObserversForKey:key];
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (instancetype)initWithPhoto:(LTBPhoto *)photo
{
    if (self = [super init]) {
        _photo = photo;
        _ready = YES;
    }
    return self;
}

- (void)start
{
    self.ready = NO;
    self.executing = YES;
    
    NSURL *url = self.photo.imageURL.httpsURL;
    
    self.dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (self.cancelled) {
            self.executing = NO;    // Swift has defer ObjC doesn't, defer makes sure to run the code you want before
            self.finished = YES;    // every return w/o needing to write it every time
            return;                 // Since Objc doesn't have defer, we need to write the code multiple times
        }
        
        if (error) {
            NSLog(@"Error fetching data for %@: %@", self.photo, error);
            
            self.executing = NO;
            self.finished = YES;
            return;
        }
        
        if (data) {
            self.image = [[UIImage alloc] initWithData:data];
        }
        
        self.executing = NO;
        self.finished = YES;
    }];
    
    [self.dataTask resume];
    
}

- (void)cancel
{
    [self.dataTask cancel];
    
    [super cancel];
}

@end
