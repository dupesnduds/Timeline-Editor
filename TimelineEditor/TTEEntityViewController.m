//
//  TTEEntityViewController.m
//  TimelineEditor
//
//  Created by Cleave Pokotea on 23/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "TTEEntityViewController.h"
#import "TTESpritePropertiesViewController.h"

@implementation TTEEntityViewController

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {}
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
- (id)initWithEntities:(NSMutableDictionary *)entityList 
{
	if ((self = [super initWithStyle:UITableViewStylePlain])) 
    {
		entities = entityList;
	}
	return self;
}

- (void)editEntity:(Entity *)entity creation:(BOOL)newEntity
{
    LOG_CML;
    
	isNewEntity = newEntity;
    editEntity = entity;
    
    TTESpritePropertiesViewController *tempSpritePropertiesViewController = [[TTESpritePropertiesViewController alloc] initWithSprite:(Sprite *) entity];
    
    tempSpritePropertiesViewController.modalPresentationStyle = UIModalPresentationFormSheet; //UIModalPresentationPageSheet;
    tempSpritePropertiesViewController.modalDelegate = self;
    [self presentModalViewController:tempSpritePropertiesViewController animated:YES];     
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [entities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *key = [[entities allKeys] objectAtIndex:indexPath.row];
	Entity *entity = [entities objectForKey:key];
	
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	cell.textLabel.text = entity.name;
    
    return cell;
}

#pragma mark - Table view delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[entities allKeys] objectAtIndex:indexPath.row];
	Entity *entity = [entities objectForKey:key];
	
	[delegate didSelectEntity:entity];
}

#pragma mark - Modal delegates
- (void)didDismissModalViewWithDone 
{
    LOG_CML;
    
	if (isNewEntity)
    {
        [delegate didCreateEntity:editEntity];
    }	
	
	[self dismissModalViewControllerAnimated:YES];
}

- (void)didDismissModalViewWithDelete 
{
    [delegate didDeleteEntity:editEntity];
	[self dismissModalViewControllerAnimated:YES];
}

@end
