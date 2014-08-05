//
//  CMLTUser.h
//  Cloudmine Learning Trail iOS
//
//  Created by Charles Burnett on 7/30/14.
//  Copyright (c) 2014 CloudMine. All rights reserved.
//

#import "CMUser.h"

@interface CMLTUser : CMUser

@property (strong, nonatomic) NSString * name;
@property (assign) NSInteger clicks;
@property (assign) NSInteger blue;
@property (assign) NSInteger red;

@end
