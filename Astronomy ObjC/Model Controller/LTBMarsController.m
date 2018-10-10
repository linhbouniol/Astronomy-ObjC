//
//  LTBMarsController.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBMarsController.h"
#import "LTBRover.h"
#import "LTBPhoto.h"

static NSString * const baseURLString = @"https://api.nasa.gov/mars-photos/api/v1";
static NSString * const apiKeyString = @"qzGsj0zsKk6CA9JZP1UjAbpQHabBfaPg2M5dGMB7";

@implementation LTBMarsController

- (void)fetchRoverWithName:(NSString *)name completion:(void (^)(LTBRover * _Nullable rover, NSError * _Nullable error))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:@"manifests"];
    baseURL = [baseURL URLByAppendingPathComponent:name];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
//    NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKeyString];
//    components.queryItems = @[apiKey]; //[components setQueryItems:@[apiKey]];
    components.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:apiKeyString]];
    
    NSURL *url = [components URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error fetching data: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        
        if (!data) {
            NSLog(@"Data is missing");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, [[NSError alloc] init]);
            });
            return;
        }
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        // make sure what you got back is actually a dictionary
        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a dictionary");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, [[NSError alloc] init]);
            });
            return;
        }
        
        NSDictionary *roverDict = dictionary[@"photo_manifest"];
        LTBRover *rover = [[LTBRover alloc] initWithDictionary:roverDict];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(rover, nil);
        });
    }] resume];
}

- (void)fetchPhotosFromRover:(LTBRover *)rover onSol:(NSInteger)sol completion:(void (^)(NSArray<LTBPhoto *> * _Nullable photos, NSError * _Nullable error))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    baseURL = [baseURL URLByAppendingPathComponent:@"rovers"];
    baseURL = [baseURL URLByAppendingPathComponent:rover.name];
    baseURL = [baseURL URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *solQueryItem = [NSURLQueryItem queryItemWithName:@"sol" value:[NSString stringWithFormat:@"%ld", (long)sol]];
        NSURLQueryItem *apiKey = [NSURLQueryItem queryItemWithName:@"api_key" value:apiKeyString];
        components.queryItems = @[solQueryItem, apiKey];
    
    
    NSURL *url = [components URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error fetching data: %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
            return;
        }
        
        if (!data) {
            NSLog(@"Data is missing");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, [[NSError alloc] init]);
            });
            return;
        }
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        // make sure what you got back is actually a dictionary
        if (![dictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON was not a dictionary");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, [[NSError alloc] init]);
            });
            return;
        }
        
        NSArray *photoDicts = dictionary[@"photos"];
        NSMutableArray *photoArray = [[NSMutableArray alloc] init];
        for (NSDictionary *photoDict in photoDicts) {
            LTBPhoto *photo = [[LTBPhoto alloc] initWithDictionary:photoDict];
            [photoArray addObject:photo];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(photoArray, nil);
        });
    }] resume];
}

@end
