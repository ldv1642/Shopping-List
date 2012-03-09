//
//  MyDocument.h
//  Shopping List
//
//  Created by jizcakes on 19/02/2012.
//  Copyright __MyCompanyName__ 2012 . All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument
{
	IBOutlet NSTableView *shoppingListTableView;
	IBOutlet NSTextField *newShoppingItemTextField;

	NSMutableArray *shoppingListArray;
}

-(IBAction) addNewItem:(id)sender;
-(IBAction) deleteItem:(id)sender;
@end
