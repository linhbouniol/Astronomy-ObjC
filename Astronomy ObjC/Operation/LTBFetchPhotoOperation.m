//
//  LTBFetchPhotoOperation.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/10/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBFetchPhotoOperation.h"
#import "LTBPhoto.h"

@interface LTBFetchPhotoOperation ()

@property (nonatomic) LTBPhoto *photo;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@property (nonatomic) NSURL *imageURL;

// NSOperation States
@property (nonatomic, readwrite, getter=isReady) BOOL ready;
@property (nonatomic, readwrite, getter=isExecuting) BOOL executing;
@property (nonatomic, readwrite, getter=isFinished) BOOL finished;

@end

@implementation LTBFetchPhotoOperation

@synthesize ready = _ready;
@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)initWithPhoto:(LTBPhoto *)photo
{
    if (self = [super init]) {
        _photo = photo;
        _dataTask = [[NSURLSessionDataTask alloc] init];
        _ready = YES;
    }
    return self;
}

- (void)start
{
    self.executing = YES;
    
    NSURL *url = self.photo.imageURL;
    
    self.dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching data %@", error);
            return;
        }
        
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.imageURL = [[NSURL alloc] initWithString:dataString];
        
        self.finished = YES;
    }];
    
    [self.dataTask resume];
    
}

- (void)cancel
{
    [self.dataTask cancel];
}

@end
