//
//  CMLTUser.m
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/30/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMLTUser.h"

@implementation CMLTUser

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_blue forKey:@"blue"];
    [aCoder encodeInteger:_red forKey:@"red"];
    [aCoder encodeInteger:_clicks forKey:@"clicks"];
}

- (id)initWithCoder:(NSCoder *)aCoder {
    if ((self = [super initWithCoder:aCoder])) {
        _name = [aCoder decodeObjectForKey:@"name"];
        _blue = [aCoder decodeIntegerForKey:@"blue"];
        _red = [aCoder decodeIntegerForKey:@"red"];
        _clicks = [aCoder decodeIntegerForKey:@"clicks"];
    }
    return self;
}

@end
