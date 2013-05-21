//
//  SearchTableViewController.h
//  PracticeLibrarySearch
//
//  Created by Bobby Koczon on 1/16/13.
//  Copyright (c) 2013 Bobby Koczon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController {
    IBOutlet UITextField *catalogSearchBar; 
}

-(IBAction)search:(id)sender;

@end
