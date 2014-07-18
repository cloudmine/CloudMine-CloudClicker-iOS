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
    [aCoder encodeInteger:_blueCloudScore forKey:@"blueCloudScore"];
    [aCoder encodeInteger:_redCloudScore forKey:@"redCloudScore"];
    [aCoder encodeInteger:_totalCloudScore forKey:@"totalCloudScore"];
}

- (id)initWithCoder:(NSCoder *)aCoder {
    if ((self = [super initWithCoder:aCoder])) {
        _blueCloudScore = [aCoder decodeIntegerForKey:@"blueCloudScore"];
        _redCloudScore = [aCoder decodeIntegerForKey:@"redCloudScore"];
        _totalCloudScore = [aCoder decodeIntegerForKey:@"totalCloudScore"];
    }
    return self;
}

@end
