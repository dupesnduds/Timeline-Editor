//
//  Keyframe.m
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "Keyframe.h"

@implementation Keyframe

@synthesize position;
@synthesize time;
@synthesize frame;
@synthesize rotation;
@synthesize opacity;
@synthesize scale;
@synthesize animate;
@synthesize fromFrame;
@synthesize toFrame;

// Init and set defaults (full opacity & full scale)
- (id)init 
{
	if ((self = [super init])) 
    {
		[self setDefaults];
	}
	return self;
}

- (void)setDefaults
{
    opacity = 255;
    scale = 1.0f;
}

@end
