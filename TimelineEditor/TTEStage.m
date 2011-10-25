//
//  TTEStage.m
//  TimelineEditor
//
//  Created by Cleave Pokotea on 21/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "TTEStage.h"
#import <QuartzCore/QuartzCore.h>
#import "TTEEntityViewController.h"
#import "TTESpritePropertiesViewController.h"

@implementation TTEStage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        LOG(@"Stage init");
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    fileLoaded = nil;
    selectedFrameTime = 0.0f;
    entityKey = 1;
    
    entities = [[NSMutableDictionary alloc] init];
    entityNodes = [[NSMutableDictionary alloc] init];
    
    defaultLayer = stage.layer;
    defaultLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    defaultLayer.cornerRadius = 10.0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

#pragma mark - Delegates
-(void) didSelectFile:(NSString *)file 
{
    NSLog(@"Selected File: %@", file);
	selectedFile = file;
	[self loadStage:self];
	
	[fileBrowserPopover dismissPopoverAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{        
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    
    Entity *sprite = [[Sprite alloc] init];
    sprite.name = @"[Change Name]";
    sprite.position = CGPointMake(screenSize.width/2, screenSize.height/2);
    
    [self showEntities:nil];
    TTEEntityViewController *tempEntityViewController = (TTEEntityViewController *) entityPopover.contentViewController;
    [tempEntityViewController editEntity:sprite creation:YES];
}

- (void)didCreateEntity:(Entity *)entity 
{
    LOG_CML;
    
    entity.key =[NSString stringWithFormat:@"%d", entityKey];
    entityKey++;
    
	[self didModifyEntity:entity];
	[entities setObject:entity forKey:entity.key];
    
    LOG(@"Entity: %@", entity.key);
}

- (void)didModifyEntity:(Entity *)entity 
{
    LOG_CML;
    
	[spritePopover dismissPopoverAnimated:YES];
    
    Sprite *sprite = (Sprite *)entity;

    if ([entityNodes objectForKey:entity.key] != nil) 
    {
        [entityNodes removeObjectForKey:entity.key];
        // TODO: remove CALayer
    }
    
    UIImage *img = [UIImage imageNamed:sprite.file];
    
    sprite.frameWidth = CGImageGetWidth(img.CGImage); 
    sprite.frameHeight = CGImageGetHeight(img.CGImage);
    
    CALayer *sublayer = [CALayer layer];
    [sublayer setContents:(id) img.CGImage];
    [sublayer setFrame: CGRectMake(0, 0, sprite.frameWidth, sprite.frameHeight)];
    [sublayer setPosition: sprite.position];

    [defaultLayer addSublayer:sublayer];
    
    [stageLayers setObject:sublayer forKey:sprite.key];
    [entityNodes setObject:sprite forKey:sprite.key];
}

- (void)didSelectEntity:(Entity *)entity 
{
	if (spritePopover != nil) 
    {
		[spritePopover dismissPopoverAnimated:YES];
	}
    
    selectedEntity = entity;
}


- (void)didDeleteEntity:(Entity *)entity 
{
	[spritePopover dismissPopoverAnimated:YES];
	[entities removeObjectForKey:entity.key];
}

- (void)didAddSprite:(Entity *)sprite
{}

- (void)didDismissSpritePropertiesWithDone
{}


#pragma mark - Actions
- (void)addEntity:(id)sender 
{
    /*
     Add: Sprite(image), Audio, Movie
     
     TODO: replace with UIPopover
     */
	UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:@"Add Entity"
								 delegate:self
								 cancelButtonTitle:@"Cancel"
								 destructiveButtonTitle:nil
								 otherButtonTitles:@"Sprite",nil];
	
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.view];
}

- (void)showEntities:(id)sender 
{
	TTEEntityViewController *tempEntityViewController = [[TTEEntityViewController alloc] initWithEntities:entities];
	tempEntityViewController.delegate = self;
	
	entityPopover = [[UIPopoverController alloc] initWithContentViewController:tempEntityViewController];
    [entityPopover presentPopoverFromRect:CGRectMake(650, 505, 10, 10) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)loadStage:(id)sender 
{
    NSLog(@"Load Stage");
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [documentsPath stringByAppendingPathComponent:fileLoaded];
    
    entities = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    
    if (entities != nil) 
    {
        for (NSString *key in [entityNodes allKeys]) 
        {

        }
        
        
        for (Entity *entity in [entities allValues]) 
        {

        }
    }
}

#pragma mark - Touch me

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{    
	UITouch *touch = [touches anyObject];
	CGPoint pt = [touch locationInView:touch.view];
	
	for (NSString *key in [entities allKeys]) 
    {
		Entity *entity = [entities objectForKey:key];
        
        if ([entity class] == [Sprite class])
        {
            Sprite *sprite = [entityNodes objectForKey:key];
            
            float halfWidth = sprite.frameWidth / 2;
            float halfHeight = sprite.frameHeight / 2;
            
            CGRect rect = CGRectMake(sprite.position.x - halfWidth, sprite.position.y - halfHeight, sprite.frameWidth, sprite.frameHeight);
            
            if (CGRectContainsPoint(rect, pt)) 
            {
                LOG_CML;
                LOG(@"Sprite grabbed | Entity: %@", entity.key);
                
                [self didSelectEntity:entity];
                isDraggingSelectedEntity = YES;
            }
        }
	}
	
	if (!isDraggingSelectedEntity) 
    {
		isDraggingStage = YES;
        selectedEntity = nil;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UITouch *touch = [touches anyObject];
	CGPoint pt = [touch locationInView:touch.view];
	
	if (isDraggingStage) 
    {
		//CGPoint prevPt = [touch previousLocationInView:touch.view];
	} 
    else if (isDraggingSelectedEntity) 
    {
		if (selectedEntity != nil ) 
        {
            LOG_CML;
            LOG(@"Moving sprite");
            
			Sprite *sprite = [entityNodes objectForKey:selectedEntity.key];
            selectedEntity.position = sprite.position = CGPointMake(pt.x, pt.y);
            
            CALayer *spritelayer = [stageLayers objectForKey:selectedEntity.key];
            
            // Wrap for CALayer drag
            [CATransaction begin];
            //[CATransaction setValue:[NSNumber numberWithBool:YES] forKey:kCATransactionDisableActions];
            [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
            [spritelayer setPosition:pt];
            [CATransaction commit];
            
            //[stageLayers setObject:spritelayer forKey:sprite.key];
            			
			Keyframe *frame = [selectedEntity keyframeAtTime:selectedFrameTime];
			
			if (frame == nil) 
            {}
			
			previousKeyframe = [selectedEntity lastKeyframeBefore:frame.time];
		}		
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (isDraggingStage) 
    {
		isDraggingStage = NO;
	}
	
	if (isDraggingSelectedEntity) 
    {		
		isDraggingSelectedEntity = NO;        
	}
}



@end
