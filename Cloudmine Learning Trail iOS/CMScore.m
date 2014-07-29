//
//  CMScore.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/18/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMScore.h"

@implementation CMScore
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeInteger:_blueCloudScore forKey:@"blueCloudScore"];
    [aCoder encodeInteger:_redCloudScore forKey:@"redCloudScore"];
    [aCoder encodeInteger:_totalCloudScore forKey:@"totalCloudScore"];
}

- (id)initWithCoder:(NSCoder *)aCoder {
    if ((self = [super initWithCoder:aCoder])) {
        _username = [aCoder decodeObjectForKey:@"username"];
        _blueCloudScore = (int)[aCoder decodeIntegerForKey:@"blueCloudScore"];
        _redCloudScore = (int)[aCoder decodeIntegerForKey:@"redCloudScore"];
        _totalCloudScore = (int)[aCoder decodeIntegerForKey:@"totalCloudScore"];
    }
    return self;
}

@end
