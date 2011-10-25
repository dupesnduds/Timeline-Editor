//
//  TTESpritePropertiesViewController.m
//  TimelineEditor
//
//  Created by Cleave Pokotea on 23/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "TTESpritePropertiesViewController.h"

@implementation TTESpritePropertiesViewController

//@synthesize sprite;
@synthesize modalDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {}
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    fileNameTextField.text = sprite.file;
	nameTextField.text = sprite.name;
	posXTextField.text = [NSString stringWithFormat:@"%.2f", sprite.position.x];
	posYTextField.text = [NSString stringWithFormat:@"%.2f", sprite.position.y];
	frameWidthTextField.text = [NSString stringWithFormat:@"%.2f", sprite.frameWidth];
	frameHeightTextField.text = [NSString stringWithFormat:@"%.2f", sprite.frameHeight];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
- (id)initWithSprite:(Sprite *)initSprite 
{
	self = [super initWithNibName:@"TTESpritePropertiesView" bundle:nil];
    if (self) 
    {
		sprite = initSprite;
    }
    return self;
}

- (void)addSprite:(Entity *)entity
{
	if ([entity class] == [Sprite class]) 
    {		
		TTESpritePropertiesViewController *tempSpritePropertiesViewController = [[TTESpritePropertiesViewController alloc] initWithSprite:(Sprite *) entity];
        
		UIPopoverController *spritePopover = [[UIPopoverController alloc] initWithContentViewController:tempSpritePropertiesViewController];
        [spritePopover presentPopoverFromRect:CGRectMake(400, 400, 100, 120) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
}

- (IBAction)dismissViewWithDone:(id)sender 
{
	sprite.name = nameTextField.text;
	sprite.file = fileNameTextField.text;
	sprite.position = CGPointMake([posXTextField.text floatValue], [posYTextField.text floatValue]);
    sprite.frameWidth = [frameWidthTextField.text floatValue];
	sprite.frameHeight = [frameHeightTextField.text floatValue];
	
	[modalDelegate didDismissModalViewWithDone];
}

- (IBAction)browseFiles:(id)sender 
{
	UIButton *bt = (UIButton *)sender;
	
	TTEFileBrowser *tempFileBrowser = [[TTEFileBrowser alloc] initWithExtensions:[NSArray arrayWithObjects:@".png",nil]];
	tempFileBrowser.delegate = self;
	
	fileBrowserPopover = [[UIPopoverController alloc] initWithContentViewController:tempFileBrowser];
	[fileBrowserPopover presentPopoverFromRect:bt.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark - delegate
-(void) didSelectFile:(NSString *)file 
{
	fileNameTextField.text = file;
	[fileBrowserPopover dismissPopoverAnimated:YES];
}

#pragma mark - Modal delegates
- (void)didDismissModalViewWithDone 
{
	//[delegate didCreateEntity:editEntity];
    //[spritePopover dismissPopoverAnimated:YES];
}

- (void)didDismissModalViewWithDelete 
{}

@end
