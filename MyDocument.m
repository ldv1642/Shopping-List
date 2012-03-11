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
    //check we have a row selected
    if ([shoppingListTableView selectedRow] >= 0) 
    {
		NSAlert *safeToDelete = [[NSAlert alloc] init];
		[safeToDelete setAlertStyle:NSWarningAlertStyle];
		[safeToDelete setInformativeText:@"This can not be undone"];
		[safeToDelete setMessageText:@"Sure you want to delete the item?"];
		[safeToDelete addButtonWithTitle:@"Delete"];
		[safeToDelete addButtonWithTitle:@"Cancel"];
		
        //capture what button was clicked
		int buttonClicked = [safeToDelete runModal];
        //if cancel then return
		if(buttonClicked == NSAlertSecondButtonReturn)
		{
            //cleanup
			[safeToDelete release];
			return;
		}
		//else delete item
        //clean up
		[safeToDelete release];
		//remove item at row selected and reload
        [dictionaryListArray removeObjectAtIndex:[shoppingListTableView selectedRow]];
        [shoppingListTableView reloadData];
        
        //mark doc as dirty
        [self updateChangeCount:NSChangeDone];
    }
}

//check for whitespace before submitting a new item to the array, reload data on addition
-(IBAction) addNewItem:(id)sender
{
	NSString *newItem = [newShoppingItemTextField stringValue];
    NSMutableDictionary *shoppListDictionary = [[NSMutableDictionary alloc] init];
    
    //check we have text to submit
    if([newItem length] > 0)
    {
        //make a new dictionary item and add to array of items
        [shoppListDictionary setObject:newItem forKey:@"Item"];
        [dictionaryListArray addObject:shoppListDictionary];
        [shoppingListTableView reloadData];
        
        //clear text box. is there a better way?
		if(sender == newShoppingItemTextField)
			[newShoppingItemTextField setStringValue:@""];
        
        //set doc dirty
        [self updateChangeCount:NSChangeDone];
			
    }
    
    //clean up
    [shoppListDictionary release];
    
}

//mandatory protocol implementations so table can query data source and retrive
//objects to populate table view
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [dictionaryListArray count];
}
//repeatedly called while filling up table view
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return [[dictionaryListArray objectAtIndex:rowIndex ]
            valueForKey:@"Item"];
}
//inplace editing of values in tableview
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
    if([anObject length] > 0) 
    {
        //new dictionary for item to replace
        NSMutableDictionary *shoppingListDictionary = [[NSMutableDictionary alloc]init];
        [shoppingListDictionary setValue:anObject forKey:@"Item"];
        //replace old dictionary with new
        [dictionaryListArray replaceObjectAtIndex:rowIndex withObject:shoppingListDictionary];
        [shoppingListTableView reloadData];
        
        //clean up
        [shoppingListDictionary release];
        //set document to be dirty
		[self updateChangeCount:NSChangeDone];
    }
}
//--
- (id)init
{
    self = [super init];
    if (self) {
        //array to hold items as dictionaries
        dictionaryListArray = [[NSMutableArray alloc] init ];
        //test dictionary
        NSMutableDictionary *shoppingListDictionary = [[NSMutableDictionary alloc]init];
        [shoppingListDictionary setValue:@"Bread" forKey:@"Item"];
        [dictionaryListArray addObject: shoppingListDictionary];
        //set source of data for table view
        [shoppingListTableView setDataSource:dictionaryListArray];
        
        //clean up
        [shoppingListDictionary release];
    
    }
    return self;
}

-(void)dealloc
{
    [dictionaryListArray release];
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
    //return [shoppingListArray writeToURL:absoluteURL atomically:true];

}

- (BOOL)readFromURL:(NSURL *)absoluteURL ofType:(NSString *)typeName error:(NSError **)outError
{
	//[shoppingListArray release];
   // shoppingListArray = [[NSMutableArray alloc] initWithContentsOfURL:absoluteURL];
	//[shoppingListTableView reloadData];

   // return true;
    
}

@end
