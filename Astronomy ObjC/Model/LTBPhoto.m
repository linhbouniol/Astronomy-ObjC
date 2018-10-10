//
//  LTBPhoto.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBPhoto.h"
#import "LTBCamera.h"

@implementation LTBPhoto

- (instancetype)initWithPhotoId:(NSInteger)photoId sol:(NSInteger)sol camera:(LTBCamera *)camera earthDate:(NSString *)earthDate imageURL:(NSURL *)imageURL
{
    if (self = [super init]) {
        _photoId = photoId;
        _sol = sol;
        _camera = camera;
        _earthDate = earthDate;
        _imageURL = imageURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger photoId = [dictionary[@"id"] integerValue];
    
    NSInteger sol = [dictionary[@"sol"] integerValue];
    
    NSDictionary *cameraDict = dictionary[@"camera"];
    LTBCamera *camera = [[LTBCamera alloc] initWithDictionary:cameraDict];

    NSString *earthDate = dictionary[@"earth_date"];
    
    NSString *urlString = dictionary[@"img_src"];
    NSURL *imageURL = [[NSURL alloc] initWithString:urlString];
    
    return [self initWithPhotoId:photoId sol:sol camera:camera earthDate:earthDate imageURL:imageURL];
}

@end
