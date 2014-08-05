//
//  CMLTCloud.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/30/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTCloud.h"

@implementation CMLTCloud
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_cmid forKey:@"cmid"];
    [aCoder encodeInteger:_clicks forKey:@"clicks"];
}

- (id)initWithCoder:(NSCoder *)aCoder {
    if ((self = [super initWithCoder:aCoder])) {
        _cmid = [aCoder decodeObjectForKey:@"cmid"];
        _clicks = [aCoder decodeIntegerForKey:@"clicks"];
    }
    return self;
}
@end
