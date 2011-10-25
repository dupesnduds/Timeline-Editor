//
//  TTEStage.h
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entity.h"
#import "Sprite.h"
#import "Keyframe.h"
#import "TTEFileBrowser.h"

@interface TTEStage : UIViewController <EntityDelegate, TTEFileBrowserDelegate, UIActionSheetDelegate>
{
    IBOutlet UIView *stage;
    CALayer *defaultLayer;
    NSMutableDictionary *stageLayers;
    
    NSMutableDictionary *entities;
	NSMutableDictionary *entityNodes;
    	
	CGRect stageBounds;
    BOOL isDraggingStage;
	
	Entity *selectedEntity;
    int entityKey;
    NSString *fileLoaded;
    BOOL isDraggingSelectedEntity;
    
    UIPopoverController *spritePopover;
    UIPopoverController *entityPopover;
    
    float selectedFrameTime;
    Keyframe *previousKeyframe;
    
    NSString *selectedFile;
    UIPopoverController *fileBrowserPopover;
}

- (IBAction)addEntity:(id)sender;
- (IBAction)showEntities:(id)sender;
- (void)loadStage:(id)sender;

@end
