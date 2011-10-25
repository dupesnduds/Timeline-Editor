//
//  TTEFileBrowser.m
//  TimelineEditor
//
//  Created by Cleave Pokotea on 23/10/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//

#import "TTEFileBrowser.h"

@implementation TTEFileBrowser

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self listFiles];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
- (id)initWithExtensions:(NSArray *)extension
{
	if ((self = [super initWithStyle:UITableViewStylePlain])) 
    {
		fileExtensions = extension;
	}
	return self;
}

- (void)listFiles 
{
	NSString *resourcesPath = nil;
	
    resourcesPath = [[NSBundle mainBundle] bundlePath];
    NSLog(@"Resource Path: %@", resourcesPath);
	
	NSError *err;
	
	directoryContent = [[NSMutableArray alloc] init];
	
	NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcesPath error:&err];
	
	for (NSString *path in contents) 
    {
		for (NSString *ext in fileExtensions) 
        {
			if ([path hasSuffix:ext]) 
            {
				[directoryContent addObject:path];
				break;
			}
		}
	}
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [directoryContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [directoryContent objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate didSelectFile:[directoryContent objectAtIndex:indexPath.row]];
}

@end
