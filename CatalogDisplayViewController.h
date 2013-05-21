//
//  CatalogDisplayViewController.h
//  PracticeLibrarySearch
//
//  Created by Bobby Koczon on 1/16/13.
//  Copyright (c) 2013 Bobby Koczon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogDisplayViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSString *titleString;

@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) NSString *yearString;

@property (strong, nonatomic) IBOutlet UILabel *numberOfEntriesLabel;
@property (strong, nonatomic) NSString *numberOfEntriesString;

@end
