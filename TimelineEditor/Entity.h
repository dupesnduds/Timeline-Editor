//
//  Entity.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Keyframe.h"

/*
 Thinking out loud...
 
 An entity needs a name, and position (x,y). A unique key so it can be accessed 
 quickly and directly. An associated timeline and 
 */
@interface Entity : NSObject
{
    NSString *name;
	CGPoint position;
    NSString *key;
	
	NSMutableArray *timeline;
	
	float currentTime;
	NSMutableArray *framesProcessed;
}

@property (readwrite,retain) NSString *name;
@property (readwrite,retain) NSString *key;
@property (readwrite,assign) CGPoint position;
@property (readonly,retain) NSMutableArray *timeline;

- (void)setDefaults;
- (void)updateTimeline:(float)deltaTime;
- (void)addKeyframe:(Keyframe *)frame;
- (Keyframe *)keyframeAtTime:(float)time;
- (Keyframe *)lastKeyframeBefore:(float)time;
- (Keyframe *)nextKeyframeAfter:(Keyframe *)frame;
- (Keyframe *)newKeyframe;

@end

@protocol EntityDelegate <NSObject>

@optional
- (void)didSelectEntity:(Entity *)entity;
- (void)didModifyEntity:(Entity *)entity;
- (void)didCreateEntity:(Entity *)entity;
- (void)didDeleteEntity:(Entity *)entity;

@end
