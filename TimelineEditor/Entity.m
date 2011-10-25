//
//  Entity.m
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "Entity.h"

@implementation Entity

@synthesize name;
@synthesize key;
@synthesize position;
@synthesize timeline;

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
    currentTime = 0;
    framesProcessed = [[NSMutableArray alloc] init];
    timeline = [[NSMutableArray alloc] init];
}

- (void)updateTimeline:(float)deltaTime
{
	currentTime += deltaTime;
}

- (void)addKeyframe:(Keyframe *)frame 
{
	[timeline addObject:frame];
	[timeline sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES]]];
}

- (Keyframe *)keyframeAtTime:(float)time 
{
	for (Keyframe *frame in timeline)
    {
		if (frame.time == time) 
        {
			return frame;
		}
	}
	
	return nil;
}

- (Keyframe *)lastKeyframeBefore:(float)time 
{
	Keyframe *lastFrame = nil;
	int i = 0;
	
	while (i < [timeline count] && ((Keyframe *)[timeline objectAtIndex:i]).time < time) 
    {
		lastFrame = [timeline objectAtIndex:i];
		i++;
	}
	
	return lastFrame;
}

- (Keyframe *)nextKeyframeAfter:(Keyframe *)frame 
{
	int i = [timeline indexOfObject:frame];
	
	if (i + 1 < [timeline count]) 
    {
		return [timeline objectAtIndex:i + 1];
	}
	
	return nil;
}

- (Keyframe *)newKeyframe 
{
	for (Keyframe *frame in timeline) 
    {
		if (currentTime >= frame.time && [framesProcessed indexOfObject:frame] == NSNotFound)
        {
			[framesProcessed addObject:frame];
            
			return frame;
		}
	}
	return nil;
}


@end
