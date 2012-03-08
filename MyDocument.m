//
//  MyDocument.m
//  Shopping List
//
//  Created by jizcakes on 19/02/2012.
//  Copyright __MyCompanyName__ 2012 . All rights reserved.
//	

#import "MyDocument.h"

@implementation MyDocument

-(IBAction)deleteItem:(id)sender
{
    if ([shoppingListTableView selectedRow] >= 0) 
    {
		[self updateChangeCount:NSChangeDone];
        NSInteger selRow = [shoppingListTableView selectedRow];
        [shoppingListArray removeObjectAtIndex:selRow];
        [shoppingListTableView reloadData];
    }
}

//check for whitespace before submitting a new item to the array, reload data on addition
-(IBAction) addNewItem:(id)sender
{
	NSString *newItem = [newShoppingItemTextField stringValue];
    if([newItem length] > 0)
    {
		[self updateChangeCount:NSChangeDone];
        [shoppingListArray addObject:newItem];
        [shoppingListTableView reloadData];
        //clear text box. is there a better way?
        [newShoppingItemTextField setStringValue:@""];
    }
    
}

//mandatory protocol implementations so table can query data source and retrive
//objects to populate table view
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [shoppingListArray count];
}
//repeatedly called while filling up table view
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return [shoppingListArray objectAtIndex:rowIndex];
}
//inplace editing of values in tableview
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
    if([(NSString*)anObject length] > 0) 
    {
		[self updateChangeCount:NSChangeDone];
        [shoppingListArray replaceObjectAtIndex:rowIndex withObject:anObject];
        [shoppingListTableView reloadData];
    }
}
//--
- (id)init
{
    self = [super init];
    if (self) {
		shoppingListArray = [[NSMutableArray alloc] 
							 initWithObjects:@"Eggs",@"Bread",@"Milk",nil];
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
        [shoppingListTableView setDataSource:shoppingListArray];
        //[shoppingListTableView reloadData];
    
    }
    return self;
}

-(void)dealloc
{
	[shoppingListArray release];
	[super dealloc];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (BOOL)writeToURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
    return [shoppingListArray writeToURL:absoluteURL atomically:true];

}

- (BOOL)readFromURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
	[shoppingListArray release];
    shoppingListArray = [[NSMutableArray alloc] initWithContentsOfURL:absoluteURL];
	[shoppingListTableView reloadData];

    return true;
    
}

@end
