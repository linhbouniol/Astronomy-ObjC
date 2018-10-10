//
//  LTBRover.m
//  Astronomy ObjC
//
//  Created by Linh Bouniol on 10/9/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBRover.h"
#import "LTBSolDescription.h"

@implementation LTBRover

- (instancetype)initWithName:(NSString *)name
                  launchDate:(NSString *)launchDate
                 landingDate:(NSString *)landingDate
                      status:(NSString *)status
                      maxSol:(NSInteger)maxSol
                     maxDate:(NSString *)maxDate
              numberOfPhotos:(NSInteger)numberOfPhotos
             solDescriptions:(NSArray<LTBSolDescription *> *)solDescriptions
{
    if (self = [super init]) {
        _name = name;
        _launchDate = launchDate;
        _landingDate = landingDate;
        _status = status;
        _maxSol = maxSol;
        _maxDate = maxDate;
        _numberOfPhotos = numberOfPhotos;
        _solDescriptions = solDescriptions;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dicitonary
{
    NSString *name = dicitonary[@"name"];
    NSString *launchDate = dicitonary[@"launch_date"];
    NSString *landingDate = dicitonary[@"landing_date"];
    NSString *status = dicitonary[@"status"];
    NSInteger maxSol = [dicitonary[@"max_sol"] integerValue];
    NSString *maxDate = dicitonary[@"max_date"];
    NSInteger numberOfPhotos = [dicitonary[@"total_photos"] integerValue];
    
    // sol description is an array of dictionaries, loop through array, create object, add to array
    NSArray *solDescriptionDicts = dicitonary[@"photos"];
    NSMutableArray *solDescriptionArray = [[NSMutableArray alloc] init];
    for (NSDictionary *solDescriptionDict in solDescriptionDicts) {
        LTBSolDescription *solDescription = [[LTBSolDescription alloc] initWithDictionary:solDescriptionDict];
        [solDescriptionArray addObject:solDescription];
    }
    
    return [self initWithName:name
                   launchDate:launchDate
                  landingDate:landingDate
                       status:status
                       maxSol:maxSol
                      maxDate:maxDate
               numberOfPhotos:numberOfPhotos
              solDescriptions:solDescriptionArray];
}


@end
